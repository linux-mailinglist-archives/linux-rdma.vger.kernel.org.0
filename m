Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB0B951C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbfITQSw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 12:18:52 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:36979 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfITQSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 12:18:52 -0400
Received: by mail-pf1-f182.google.com with SMTP id y5so4849174pfo.4
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2019 09:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i28mERvjGtCCRqZm/B+GKlFeRNXQpqCC9G7TVc88EMY=;
        b=OGpIIlKBhYt5nHltHnY/jrkABdJV2SVCtChmTWvMEvIv5eBrovl5rmo9vKkSecpjMf
         zX4reBt0zqeYcgqGmfRuPGL9xwJLrPdSvtQQrVKxganXKnD4I11KbYQHqx9YQRrXjcFQ
         1nFISqRN7h520cDPoTMgQlsXl+gpwq820ElhJ1azQoY0ILHqq8x5M6lqqvUcHpDfCs5d
         bqj7ykOGZbIcJZ5SzI7KN3v2Xy1quSGpgyp+Y1OrHP4PuDZiYOcoPZjzpa6cSgpKpkwC
         LQLI69mxwlSIjLqoniroU8oz9dcmTdltN17V3jEVOSMBfmShQOopx2Z7ZF7AsAOQiW6C
         vrNg==
X-Gm-Message-State: APjAAAXYn1yEM6j34DD9GqnXHs7Q2729TxoLRzzsemYkl4IHo8T2EnVG
        iX6vlSdqMahvSsTtg0Ehw8cGcwyY
X-Google-Smtp-Source: APXvYqykSIkyXPoru3JkmJHgT/WyscdjXI9z3OHddS8lS4BuJI6Vc/KXY9wBtjlnaonM17Pr9pU4qg==
X-Received: by 2002:a62:8647:: with SMTP id x68mr18817638pfd.44.1568996331006;
        Fri, 20 Sep 2019 09:18:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a21sm2688674pfi.0.2019.09.20.09.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:18:50 -0700 (PDT)
Subject: Re: [patch v3 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
To:     Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190919035032.31373-1-honli@redhat.com>
 <20190919035032.31373-2-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c0ab625a-d029-37b4-753f-312e7877a6fc@acm.org>
Date:   Fri, 20 Sep 2019 09:18:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919035032.31373-2-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/18/19 8:50 PM, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> The default maximum immediate size is too big for old srp clients,
> which without immediate data support.
         ^^^^^^^
         do not?
> 
> According to the SRP and SRP-2 specifications, the IOControllerProfile
> attributes for SRP target ports contains the maximum initiator to target
> iu length.
> 
> The maximum initiator to target iu length can be get from the subnet
                                                    ^^^
                                          retrieved? obtained?
> manager, such as opensm and opafm. We should calculate the
   ^^^^^^^

Are you sure that information comes from the subnet manager?
Isn't the LID passed to get_ioc_prof() in the srp_daemon the LID of the 
SRP target?

Anyway, since the code changes look fine to me, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
