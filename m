Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A545B64B35
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGJRHQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:07:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38786 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfGJRHP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 13:07:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so3272674wrr.5;
        Wed, 10 Jul 2019 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTapdIVWysC4BmFKF+77+HFRaZAY62cmjGq1o8w76vc=;
        b=WgX7vUmpKwcssDeQZ0MQCpS6ehrwEZDkM5PrLDqqta6OsnfC5F/Bw2Y9Vgk6sNw2Gr
         Yq58/XpF/aKiFjPlxKZM+3JMgmZ7tzLpluZX2SWGwZqyliDcjaAyYAXrJi71ipLyF1Y8
         d3URV+ecdHf25fEvfA4CvW85ZfzhvfiYe8OzWLt9aAtkLKNMLrmEI/P8NT3QGbGnZ9kK
         nPLRwL8VGEViiZy/BdIVQJVP1jEdMadH1/l+WgWrl5VX3tBfkYSyEU1dueTO+h1N6Pz8
         gAhNyadOvDm3f0iYbtgwfJ/7ieqKduIuEkabjZCWOpeq1nBmhSSbg7nQrBphy4k2Tox3
         Zmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTapdIVWysC4BmFKF+77+HFRaZAY62cmjGq1o8w76vc=;
        b=FPog9j/g4SJu2c+4cmvIcgQl20Yv04Zzpa1weJwr9gOPPOKbuGUZwQUhZIdrcy1/Up
         hgY0VpIwEChj0fzdHJePt1GEu/eDTkR2gVvm2y7ABIw5gPyr75SI0EUUQITL06VjGhya
         JERIZ1Y66OwbB0iiASMg8BKXVL2Yc5/fm5IClAjV9dtrcz0CO1sNGon+Bji1nuHZYtY/
         lR5rbbVnWdl5M/Tsi2dEmozljo3cxHu7Ddy6K9h5dCtIXYLHrlnwxo0ZJWEKYPJXS96/
         G89qB2AEB96nl91uDRZvS3HmIP5TDRYLr4Ylh/tO2kiW+ZqEq6Pw6jQoXJ+b5sJEPymP
         YZkw==
X-Gm-Message-State: APjAAAX+QjD8QFDF3l5pIkQullidtrrg8FGsBa3WTJO/F41NINfV+dM3
        pns5IrsAti2OTRES45jE9CPITU5axvojjg==
X-Google-Smtp-Source: APXvYqzlGvjJxPScjAmBHyjng9WLycfn5Ibh6mdp6sgjQFC0e/OL/AbQOXuRiD7VtdFPAH68+7a1SA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr1655148wro.307.1562778433258;
        Wed, 10 Jul 2019 10:07:13 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c12sm4348617wrd.21.2019.07.10.10.07.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:07:12 -0700 (PDT)
Date:   Wed, 10 Jul 2019 10:07:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in
 rvt_create_cq
Message-ID: <20190710170711.GA80444@archlinux-threadripper>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <20190709230552.61842-1-natechancellor@gmail.com>
 <20190710170322.GA5072@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710170322.GA5072@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 10:03:23AM -0700, Ira Weiny wrote:
> What version of the kernel was this found on?
> 
> I don't see the problem with 5.2.  AFAICS there is no 'err' in the function
> scope and the if scoped 'err' is initialized properly on line 239.
> 
> Ira
> 

$ git describe --contains 239b0e52d8aa
next-20190709~84^2~57

I should probably be better about adding 'PATCH -next' to my patches,
sorry for the confusion!

Cheers,
Nathan
