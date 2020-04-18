Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8DD1AF5D5
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 01:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgDRXRR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Apr 2020 19:17:17 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:39320 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXRR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Apr 2020 19:17:17 -0400
Received: by mail-pg1-f170.google.com with SMTP id q8so2300971pgq.6;
        Sat, 18 Apr 2020 16:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mEAgNC96kBq5+qN7gTjpSRBnUBELQTbRFmfbvyExFcw=;
        b=Zwt7j8yJqP29iV3Qi14QeOA4P6frNyfFu4lSZnO+QuYr3elmw6STghUFSr0q5QPOg+
         kRcKm/Wm+xf9z4IKn8atW4/AZUGTiGV34Qyu5HDZiu2q3KPnJPJ7cj2OOPXspklGzQJ3
         T0LB+0dEm/BySUQqB5Km4gzrFWBs57NRWjOYmmEdqSDlZJNU69aa4LYadMLSuNICaqNZ
         tY0PK2ePOv9SoIOqDOdL9Od+jClbu+3+gh12Fy/S9+QXISqqZHuocvosJnrrpc1j837c
         yd5CauKYV6rVAS4oIQBnHRDogLrQUcRqOIyHIvpyGz7eVNlwptktOmbwMD6qrsVpbkdH
         Cw5w==
X-Gm-Message-State: AGi0PuaTqa3IaFH3a3IvMXYLEn9yQdfE2H9CGGpaem4jxAvK72jtgetM
        SX0xnLc9vqMQqmOwX5EM+wc=
X-Google-Smtp-Source: APiQypIK/Yfi65l+yW2dBM0v/T75T3fQlGg1fo8JjDNz7Li8NAqo1QJTRGUZY0BAj4tGI8Z2iW4lrA==
X-Received: by 2002:a62:874e:: with SMTP id i75mr1359122pfe.248.1587251836602;
        Sat, 18 Apr 2020 16:17:16 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.61])
        by smtp.gmail.com with ESMTPSA id 6sm20234971pfj.123.2020.04.18.16.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 16:17:15 -0700 (PDT)
Subject: Re: [PATCH v12 17/25] block/rnbd: client: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-18-danil.kipnis@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <feb3bb89-5258-6c86-0a14-1b9a4d94188e@acm.org>
Date:   Sat, 18 Apr 2020 16:17:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415092045.4729-18-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/20 2:20 AM, Danil Kipnis wrote:
> This is main functionality of rnbd-client module, which provides
> interface to map remote device as local block device /dev/rnbd<N>
> and feeds RTRS with IO requests.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

