Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3D258973
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIAHmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 03:42:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38166 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIAHmD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 03:42:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id d22so324685pfn.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Sep 2020 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlyCex1NyUyuqlYFvjJxxOIZMesUDWYeK6eChF7COpU=;
        b=jXQ3i152gVjsjoaoSS5bF8Tp3sKNA32crVrddxDtpstkiOc3x/aEvZ/SvVsbMXhPb5
         DJoMp9K6N1wVDymU+fsWDRdLPEddQ3T4+qFksz227+XoBpwUdRn7DKUoLRkt7ocn3fiz
         2qZrCEPZpNGqGtoqBZMft3+LsQOIDvzBBiFzKuhD/zE+FxoJkD3kTHjQvgSPnWqTUKGj
         4h1WK0arGTa/FzpPbo2MeAZEMIhZ926Bpbf/XyKp/Z/yEIV6Tj8XnxobIft6XDc7/+s/
         TOZuyVPEfcgwapFnxymTZFYDqYZxM80WbZbR0H2wJKAc9+GvL9nNnRdyTpzw32Ost+kS
         M+5g==
X-Gm-Message-State: AOAM531LNG57zeOONn2MdweuzzD6Hb59qupjMAhlSH9bx0xGJP/+ahiJ
        bEGerJilg0KYpFdvvDCkAtQ=
X-Google-Smtp-Source: ABdhPJzdD9h5/sOU50nI9qyKd+scqdXydxQg+n3u4K+UanT8TD1NwyNyPGsCwXQVUVVhU6S+2gzm/A==
X-Received: by 2002:a63:1848:: with SMTP id 8mr419929pgy.347.1598946122957;
        Tue, 01 Sep 2020 00:42:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1? ([2601:647:4802:9070:70b6:3990:a389:c0d1])
        by smtp.gmail.com with ESMTPSA id kf10sm568599pjb.2.2020.09.01.00.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 00:42:02 -0700 (PDT)
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     doug@easyco.com, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        ming Lei <ming.lei@redhat.com>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
 <CAFx4rwRQ7z+sATpKuYNwTWqnepcWQeinxFjsZEEDAQobeSVACQ@mail.gmail.com>
 <20200831175931.GC24045@ziepe.ca> <20200901055649.GB31408@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <064a5844-f064-997a-ad95-ad395d17b3e0@grimberg.me>
Date:   Tue, 1 Sep 2020 00:42:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901055649.GB31408@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Can we put all this info in the commit message please?

Sent out v2 with an updated commit message.

> Yes, please.  Note that the block layer actually reports the
> required dma alignment.  The worst case is the logical block size,
> but many devices require less alignment.

Given that we don't know the I/O target when we get the command
with the data, its better to make sure the worst case alignment
is met rather than to bounce afterwards when we find an alignment
issue.
