Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC439BAD
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfFHIKr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 04:10:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33695 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFHIKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 04:10:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so5523733wme.0
        for <linux-rdma@vger.kernel.org>; Sat, 08 Jun 2019 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/98s+ZxLWi2AxlogIx4Ijtu1jW2DrfDadsqadJKMuo=;
        b=pCcz/EmJC6hgluYq5PvYf+aGmHKDD1vCR1Mi8XWSw3otEtjhq3rifcApmd4NBMij2u
         4D/9i3hBYMZtDWxnNb/MRtGSwBaNiUODq5uH7spiDBk+aEdHwroZ7t/JVmnwBHw/mZPF
         HpV4REQHX2jRfSIU7PK34BCZL3Ftv9jurqOR/QisIAK4GkHhmecp9epktkhQj6IBRzqw
         UifbYQdqC1H/rLMt+5f4T66G9gCzdE+oZZ7tO+JAQH4DkJEvozPUxWoe0XpBQqPhCK3q
         87fnqNTeQ68yHyg6gKX1/O24jSKM16QaXQAWgLHh7coxgbFXkJIErPwfcQ3TpxqXhI8p
         uxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/98s+ZxLWi2AxlogIx4Ijtu1jW2DrfDadsqadJKMuo=;
        b=pMRNPiOshfzVxgO54xu+4a9b1VQbUj+julXcX7I9wnCWQThii1J2g1sFoagxRBN3wQ
         hXNkdRMGhIcC6p8iH0cT/2c4Z8631kftVm+JaaS8N8vzRosQkiWRHDmsZzy2V3IDc/Qj
         ReGk0tLiuxbjq3qkfsz8lfLxN0vp8ShEOF7+Pol1Pg4Yi3xiJ2uK00qbN8IJ4ieBSUh8
         11RfpLJ1Yn94R1++0JIeG63RIqD2AtW+ocNZwCCCnPkcuQXhusWPtWSx8vEAPPaDm+t9
         phpGpvmKgsd88H4R8VrmL0vrzu/8LDVYv3fDqD/vGJa389Qpqd4FkbukER9k7imVVzhJ
         bBoA==
X-Gm-Message-State: APjAAAXBpESLqnothVe/E7HyVBqdiMazZoR9988hPnWWvoRwCAjBpu2f
        qug4S/MVuz4GZ++8orvYIaYTEQ==
X-Google-Smtp-Source: APXvYqxzdnROeTHjScvyEAbURnezUITWgF87dJmRZvr0Lb6G4TViG5IoiBIGZmRJaGL6s4d+RprNoA==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr6683506wmh.16.1559981445791;
        Sat, 08 Jun 2019 01:10:45 -0700 (PDT)
Received: from [10.97.4.179] (aputeaux-682-1-82-78.w90-86.abo.wanadoo.fr. [90.86.61.78])
        by smtp.gmail.com with ESMTPSA id e17sm3849742wrt.95.2019.06.08.01.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 01:10:44 -0700 (PDT)
Subject: Re: properly communicate queue limits to the DMA layer
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <20190605190836.32354-1-hch@lst.de>
 <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
 <20190605192405.GA18243@lst.de>
 <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk> <yq1o939i9qh.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <379c82a1-f61d-7463-791e-57f1cdeaa9db@kernel.dk>
Date:   Sat, 8 Jun 2019 02:10:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1o939i9qh.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/7/19 11:30 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>>> The SCSI bits will need a bit more review, and possibly tweaking
>>> fo megaraid and mpt3sas.  But they are really independent of the
>>> other patches, so maybe skip them for now and leave them for Martin
>>> to deal with.
>>
>> I dropped the SCSI bits.
> 
> I'll monitor and merge them.

Great, thanks Martin.

-- 
Jens Axboe

