Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB3948D7
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfHSPqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 11:46:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33151 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfHSPqB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 11:46:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so1455455pgn.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 08:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=el7674EF4eBar/UH/zKb5ZWvnbkkR4odtqUFMSxzlWs=;
        b=E/CNxBUP2nwAZgcMOGRqefi8U1wEZibwORB5gDisjEXgm/CSinj+Ox5ay9bgcUAyhW
         Vmt/VJMp3YdCm2EzsVjuCtc2T5PayXGO9ymSzDOWU1CTNIGx/L1HxvNC1We5dbGGg9Ra
         r3TNTA691yjgJP9XMmnxCK9wq9CJVixIbXkjSyLKcDKn9B8V+73fyngBO8B2iDVzSLA+
         zFNdBYNis1s4nmWdvQCx9+p3LjrmjG2VqTI7IdoJX4pcmFHYxmpQr5r/A3IDGHsBhX4v
         TlNpFwFgVOKFXg90fCKk1stqpN+d41cmtkRVCHXNmSdA4fBvDezSQxZkI2OV3xByhJqu
         K/Ww==
X-Gm-Message-State: APjAAAXzGMYiJ5lac5Ix3HWiGkINYpc898SIPFN6u0ixlnQYJvTYV2XT
        tAXJHhCc1vY+VePcaRzpC+g9Xljb
X-Google-Smtp-Source: APXvYqw7edY2B4yxv3a+xc+lDVsx1m9pKCIpLH9Atx+RMllMcIps/RediRAFVV3R4ZWLXBnzKJ1xiA==
X-Received: by 2002:a65:6096:: with SMTP id t22mr21147762pgu.204.1566229560870;
        Mon, 19 Aug 2019 08:46:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o130sm19003389pfg.171.2019.08.19.08.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:45:59 -0700 (PDT)
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
 <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
 <20190819151722.GG5080@mellanox.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ad0d3211-bf70-d349-7e14-e4b515bb3e98@acm.org>
Date:   Mon, 19 Aug 2019 08:45:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819151722.GG5080@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/19/19 8:17 AM, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2019 at 08:11:21AM -0700, Bart Van Assche wrote:
>> Does uniqueness of the I/O controller GUID only matter in InfiniBand
>> networks or does it also matter in other RDMA networks?
>>
>> How about using 0 as default value for the srpt_service_guid in RoCE
>> networks?
> 
> How does SRP connection management even work on RoCE?? The CM MADs
> still carry a service_id? How do the sides exchange the service ID to
> start the connection? Or is it ultimately overriden in the CM to use
> an IP port based service ID?

The ib_srpt kernel driver would have to set id_ext to a unique value if 
srpt_service_guid would be zero since the SRP initiator kernel driver 
uses the IOC GUID + id_ext + initiator_ext combination in its connection 
uniqueness check (srp_conn_unique()).

The ib_srp kernel driver supports both the IB/CM and the RDMA/CM. The 
srp_daemon software tells ib_srp to use the IB/CM. Software like 
blktests tells ib_srp to use the RDMA/CM. From 
https://github.com/osandov/blktests/blob/master/tests/srp/rc:

   srp_single_login \
     "id_ext=$ioc_guid,ioc_guid=$ioc_guid,dest=$dest,$add_param" \
     "$p/add_target"

The most important parameter in the login string is $dest. That is a 
string with the following format:

   <IP address>:<port number>.

Bart.
