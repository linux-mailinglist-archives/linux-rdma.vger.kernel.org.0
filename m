Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0429D9D4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 00:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbgJ1XC4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 19:02:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38197 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390036AbgJ1XCy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 19:02:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id 9so1325781oir.5;
        Wed, 28 Oct 2020 16:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sagH2PC7EpAdxZ16EOxRiHafef79Ay2C4If7MRpdFD0=;
        b=Nz0ttXFrHIcLoy97TmVDG7kAHkYFuo6+WSXIdmd04tIqm6uQCyK01QTkDoGxO4mtDc
         GABXqBbzTeo82bYn0shcMol1SaiqkAQcwnP1zoYNvqoAILOUsJ+2VInPQA42DLFOu4br
         4FkBADVJi4yX5Rdtw1HcJyxKIFUD33clieZZf94TwD7hjwxcKsV6fTUEh0HNP/9THWIV
         wGdgfnRt6bfJPA33vwqCnrArxXeE0K+K5fCpmfjqY5TY+Ddla3a16IREtwyiPzypDqkR
         jWnSVs4zl4fNfj8c9W5NDlUcEt4YTlEtqEkPe27I7qnXhriV5H4JmFjA2Tv55/FhJwlW
         HV8A==
X-Gm-Message-State: AOAM530X/rcZRLWud+4PoNwF/K85lQGwW4p+HO6Gnuq5TyoQuAZw6Shu
        Ie0ebjPZqf/oh30SVZmG+MsjbU/IJMdOdg==
X-Google-Smtp-Source: ABdhPJzwP4whIftiW07KfvAjZq1D49sITEhoT4+ERP5oeO9yebeFDCJZV91m0/iZE3SZH34ESlMiAQ==
X-Received: by 2002:a17:90b:3798:: with SMTP id mz24mr4821149pjb.46.1603856924004;
        Tue, 27 Oct 2020 20:48:44 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j19sm3867964pfn.107.2020.10.27.20.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:48:43 -0700 (PDT)
Subject: Re: [PATCH v3 20/32] IB/srpt: docs: add a description for cq_size
 member
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
 <df0e5f0e866b91724299ef569a2da8115e48c0cf.1603791716.git.mchehab+huawei@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <67ba1e15-87cc-18dd-48f1-6224cefe7105@acm.org>
Date:   Tue, 27 Oct 2020 20:48:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <df0e5f0e866b91724299ef569a2da8115e48c0cf.1603791716.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/27/20 2:51 AM, Mauro Carvalho Chehab wrote:
> Add a description for it.

It seems like my Reviewed-by tag is missing? See also
https://lore.kernel.org/linux-rdma/cb5944e2-bdea-e320-d4d1-2f9bc9539a19@acm.org/

Bart.
