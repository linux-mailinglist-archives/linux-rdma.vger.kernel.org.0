Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A735836DDF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFFH4J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 03:56:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43272 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFH4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 03:56:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so982615pfg.10;
        Thu, 06 Jun 2019 00:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lh2BylyTpraxmfd7l0Q4XRgjr9hdIC59lT3B/5ZVy0Q=;
        b=k4kcTlx4ut/lPs3PRQ+dQrPuOY0gkTMlDWJfag6ADvs6snvSs96+pohs9l00WNHKS5
         HpiK26Ja9JyJrZomEipf91M2Po8GVoln9ZcOp8K2f0pM7r0mwdSJk/mH31EFe/Do5vbU
         O+clIwIZY0mKX5T522RKWpW1kKNrnzDPz+eOK35rRER+TEGC6p+J2aUMSf+KU1GSlzwR
         nrqikPqSmJ7LB/ByyW0yU2gXrCPc1kkwLVQUV8+iHcB7NrFAhSKXDn6eMtvLqmxnB45y
         RDijR6v5+j2FOG9NBnjIUH4by8ayS9/xzMXoYdnu8EJwzw9roUClY255lsle5HUuOM3W
         gO2w==
X-Gm-Message-State: APjAAAVguyzT9GGUCbaaH9RHeubMg76FP/m31JNpPOKB9WaYFi0hXy1S
        i2f2mDCGHsX67PMF/MwZSMA=
X-Google-Smtp-Source: APXvYqxqjpcshbAdvsv1K5Uazd4bmO7Po5+pkUN3QQsR5N7WG8HFf8y/EaRIomXV1ZdWXy+wvn3FXg==
X-Received: by 2002:a62:63c6:: with SMTP id x189mr39650310pfb.31.1559807768316;
        Thu, 06 Jun 2019 00:56:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:d85c:2df7:72d9:ea63? ([2601:647:4800:973f:d85c:2df7:72d9:ea63])
        by smtp.gmail.com with ESMTPSA id t11sm906104pgp.1.2019.06.06.00.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:07 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: explicitly set shost max_segment_size
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20190606000209.26086-1-sagi@grimberg.me>
 <20190606063600.GB27033@lst.de>
 <ae65c220-193c-e526-57da-17b50820b015@grimberg.me>
 <20190606070403.GA27627@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b45229a-ad97-3885-76c0-d4dc4d27a090@grimberg.me>
Date:   Thu, 6 Jun 2019 00:56:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606070403.GA27627@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Not sure I understand.
>>
>> max_segment_size and virt_boundary_mask are related how?
> 
> virt_boundary_devices has hardware segment size of a single page (device
> page as identified by the boundary, not necessarily linux PAGE_SIZE).
> So we don't need a max_segment_size in the Linux size, as any amount of
> hardware segments fitting the virt boundary can be merged into a 'Linux
> segment'.  Because of the accouting for the merges is hard and was
> partially broken anyway we've now dropped the accounting and force the
> max_segment_size to be unlimited in the block layer if a device sets
> the virt_boundary_mask.

OK, want me to respin? or you want to wait to see if you have a v2 and
fold it in if you do?
