Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704F918B9B9
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSOtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 10:49:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCSOtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 10:49:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so1545961pfn.9
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 07:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JuHbSS0eGsYBNljx6ogyRU5OrOR3D6tnYOH5aEot1bo=;
        b=gj2ODWfAepJ9fEdzuwa9QYLqeYZ5DXTB1Ge7ZJ6i2QCPoUxqT7mZO5CavqIwXXArQs
         Q+J5mqp5TkxVLorwDWJaearu81rJ1DtMbCx20F0sLmCA3LgS8ENdcf1P1r9IZWx0590H
         j+IDqvbgYNuC9qQdF/8jeIFS0FRKttOzOYskSDlK3mJakrXYMNzzhwxGdIwab9Nmh9rG
         uwSbmW6azaPCTKMF1dYZ3vMi7dTWrZO7DELw747e0VQZ0thZMHyMiN5W+pzlPuUojCma
         P/9UJfC6vC5QCsdZ6l3fHZCcCObtu7oKzM5bR8VBU7X6D1CemeRWG214WhVnoT54GTKK
         8Jiw==
X-Gm-Message-State: ANhLgQ1Gbx6ZVca6uadGNuoZHXCjzLos1t6CRnWm8bBJsRYg+gjmbmo1
        DyjJLBLoOMos7KpF/FBbLi8=
X-Google-Smtp-Source: ADFU+vsVsNb+pyULR/67nR+rIO5LTV/Xrueh2tN2NiSmX7YZWsKNbda6OdDSE8Bh0g5Z19vwJuslFA==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr3832067pgm.28.1584629374199;
        Thu, 19 Mar 2020 07:49:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075? ([2601:647:4000:d7:af99:b4cf:6b17:1075])
        by smtp.gmail.com with ESMTPSA id y131sm2920765pfb.78.2020.03.19.07.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:49:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        leonro@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        rgirase@redhat.com
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
 <20200319115654.GV13183@mellanox.com>
 <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
 <20200319135356.GZ13183@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6dcf300c-d010-829b-b996-285ad16786d5@acm.org>
Date:   Thu, 19 Mar 2020 07:49:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319135356.GZ13183@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/19/20 6:53 AM, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2020 at 02:48:20PM +0200, Max Gurtovoy wrote:
> 
>> Nevertheless, this situation is better from the current SRQ per HCA
>> implementation.
> 
> nvme/srp/etc already use srq? I see it in the target but not initiator?
> 
> Just worried about breaking some weird target somewhere

 From the upstream SRP target driver:

static void srpt_get_ioc(struct srpt_port *sport, u32 slot,
			 struct ib_dm_mad *mad)
{
	[ ... ]
	if (sdev->use_srq)
		send_queue_depth = sdev->srq_size;
	else
		send_queue_depth = min(MAX_SRPT_RQ_SIZE,
				       sdev->device->attrs.max_qp_wr);
	[ ... ]
	iocp->send_queue_depth = cpu_to_be16(send_queue_depth);
	[ ... ]
}

I'm not sure the SRP initiator uses that data from the device management
I/O controller profile.

Anyway, with one SRQ per initiator it is possible for the initiator to
prevent SRQ overflows. I don't think that it is possible for an initiator
to prevent target side SRQ overflows if shared receive queues are shared
across multiple initiators.

Thanks,

Bart.
