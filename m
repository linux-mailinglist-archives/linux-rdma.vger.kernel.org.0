Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571F3BB79D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 17:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfIWPMe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 11:12:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34477 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfIWPMe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 11:12:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so6651339plr.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 08:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hFTdxo3NztxJ/RJ+KM3CV8kbn3+6RHRON45VoycS+Yk=;
        b=nanZbMOZAp4oznskggugpYlXIPa2V+nK2Eanxong2X0+HpTOExZ9eoX0JA6Z9IoBI4
         kEw1EoOsl2/S4Q/NR86G2TR76Xs94ESbSSs8inb3RnepIWqp684kJc5ZwmIcRpFpMZ+o
         DebVmh7Bn3VDLQaXrKZjZKqCjqP6zSS6hJYbEeZw8PvL2BfJ7cbg47lyyVLuiChGyWQ9
         EKL5ODhyc1Q3eZy8na5BZp51bTVpu9Erook29DJ0B4OMiU+LKKuKSM37W6/LWWx2sucX
         fK2IFyUW7aipaIk9LYjT7gbQ39U9Srh+w4qe3HZz7jW97aWnd+BwRIeaSPOHWMFPaMEE
         W3Mg==
X-Gm-Message-State: APjAAAWwTcZuKsvur9LAmjNyQZThMTQFyyyMhddRJHbz+A3hH4QnxtK8
        ALmCOLu5sNZIHwUfLAAsvWGztLxa
X-Google-Smtp-Source: APXvYqyF3HAoqTU0M0pMgQyFfYkvO0Yy8B+TOAmO3mEo/NtqSaVVg1cYLmI9Z5p4Jnp5nvm6KApFCQ==
X-Received: by 2002:a17:902:7886:: with SMTP id q6mr215730pll.323.1569251552974;
        Mon, 23 Sep 2019 08:12:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v1sm4485499pfg.26.2019.09.23.08.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 08:12:32 -0700 (PDT)
Subject: Re: [patch v3 1/2] RDMA/srp: Add parse function for maximum initiator
 to target IU size
To:     Honggang LI <honli@redhat.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20190919035032.31373-1-honli@redhat.com>
 <8f15fcfa-d0d8-e04b-8202-0cc56fa75941@acm.org>
 <20190923033004.GA8298@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <873ad0e5-4104-c4fb-27b5-684be673198a@acm.org>
Date:   Mon, 23 Sep 2019 08:12:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923033004.GA8298@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/19 8:30 PM, Honggang LI wrote:
> On Fri, Sep 20, 2019 at 09:11:06AM -0700, Bart Van Assche wrote:
>>
>> Something I forgot to mention last time: since this patch adds a new login
>> parameter Documentation/ABI/stable/sysfs-driver-ib_srp should be updated. I
> 
> I will submit a new patch to update 'sysfs-driver-ib_srp'.

Thanks!

Bart.
