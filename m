Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF964B37
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGJRHz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:07:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54044 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGJRHz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 13:07:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so3055959wmj.3;
        Wed, 10 Jul 2019 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYbiPKCwZLJ76GitqHRMfm5sXc+OxSYA3Irna9XDNy0=;
        b=h8ZQ7pbLw8ZjE/6no6LLOrr49HZPtwF2sWqeywXEPT0Z1A0hjPjJ3b79wcltgNPIbc
         GJDIizXA5RncZ3meryBqU+eJ4GCjtLvvKqLA0FW+aLqQ79fv16Ur1fTJ6/ZUG6bwJyQ4
         e9IsX/vB2cf6Bi2kgriZ7/8g4dF4DufTFK7gX1FY03JIihi+MPN/U7V2pHrNPXnx2Egx
         HtFs5PPAAyxm7WuGhhg4X9rG4PgjogFHQ3HYeCds+NLvwTvEfz0tvtdNBfJos+0TX2CL
         aaXGitWwaVt54O/37O9TG2nQoSE8aH2YbAeF34orWbzzK1j9UQPdyJGLRlhGbvW3c+mT
         gvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYbiPKCwZLJ76GitqHRMfm5sXc+OxSYA3Irna9XDNy0=;
        b=WnJrdBYrNOdXlh8n9xpDIbr1miCq39H9pUMI7Ty38tR7MW5dFtxVgmZZ2trOl1zgDM
         zWcIyEKzEwOUQUpbBUsLHF3kjJttdS2xiEv8W3XWb36T5OUVBzU9SiEOsPOPOdDQLWLl
         Us2GQAR0rmukEvl8wb4VNIK6+5BZXbZl3jB2ckEARwUGF/LXNavQWfF/Vb/QoQr00bSP
         PSa1Z/O8WS7oLbwxlgDb4UBdK+imMAVmxasEN1KEWVR02G5WNUQFYgvGjMFG7hfSmMl3
         SGK4e4jEaMr0iwOAa8FyqS8vWghB5ixlgHaZ3FYB08YrOPGhRLGwG0lMLnOSlE2SoD/2
         cOCw==
X-Gm-Message-State: APjAAAXgC5UkjP+J3GdoAOTCWygkDl3FhW3OUx/5pFCCITORfprcmwHo
        iUBeevDXQhKBgZjK3oY9qvA=
X-Google-Smtp-Source: APXvYqz38Rrp4/pk7sX6KGVerc3He23b6GY0puXH6Ug3AOUVPVqKd4oN78+g1Dp5yUiLb8yV/fbuQA==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr6056440wmm.83.1562778473176;
        Wed, 10 Jul 2019 10:07:53 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id y6sm3121453wmd.16.2019.07.10.10.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:07:52 -0700 (PDT)
Date:   Wed, 10 Jul 2019 10:07:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in
 rvt_create_cq
Message-ID: <20190710170751.GB80444@archlinux-threadripper>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <20190709230552.61842-1-natechancellor@gmail.com>
 <20190710170216.GA15103@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710170216.GA15103@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 02:02:16PM -0300, Jason Gunthorpe wrote:
> 
> Applied to for-next with Mike's ack
> 
> Thanks,
> Jason

Thank you Jason, much appreciated!

Nathan
