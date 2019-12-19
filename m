Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B91126904
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSSZP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 13:25:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35911 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSSZO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 13:25:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id q20so5857727qtp.3
        for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2019 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1wbEmZyh69FxPHvZMGNLVUp72qy8Qf/muGKAoj7XDfg=;
        b=V9nBP4csbVK/v9fr2ruWreq4kfAqbjElnswpw8VAmId7qRQciZLEv0HUTAcTIETfPm
         TNQ+fd+c4E82jjfPv8enquk2LE2BPncsV+dkTs/VgzYPpVXujrzmT+TO+JtPG84PKe1n
         iglq2DsPN5mSR4yA4F3sW664HfXWwXyZ76V6gxZmLT1bnZ3H57tvI1iG+1Pxybh8mFk3
         KKWNfbnRw8VOwitEm60KWVQHu2Ip7j3a0VVRaKY8gS3vNN2ZcIPRW8T230RfBO8KfhU/
         pXpF489I6+5CWj+6hfiai6ezhVSnH0ZlaKAz2XhPGPWInDMwWrlFRxdvPOHre7wntX8J
         tuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wbEmZyh69FxPHvZMGNLVUp72qy8Qf/muGKAoj7XDfg=;
        b=NUcHqW7zqEeZK6MtUhxMuvh0y5mG+YRtsD1l8jjrfxVSgP2+8x0JNxvkIfVgOM7XsK
         3xoMO1aL1Q6p3Tq/ZDrW+abmr0gZE9omm/fKIpYkhgUgyW2NInT+HCoOrM/RMeBAqDAP
         GEl5bm/tQoe21fQvWL21+aDton8iRGPSm7GkmfGY65X1Uh0Mbf+IqZ3af9LExxnO6oZh
         vZlW7j5lCM84mctXmnXPDynNfCYkTX1XASKh6wXk5qm5UNsaGZYifGcAfQ/5tkuXJ3Lg
         LG3uRrOczN+X6HlRNtN/0Kp0f1v1P1Z93bfL4SQRQVfkecyaavPI47ES4ufosuVjSKRk
         zCpQ==
X-Gm-Message-State: APjAAAV4L80Q1waWCOdvZUyZjKFftr2l7UZE3J2J+1jr4Cx/R5uqKx3u
        zWCiNZNlRXBOAVd7hDpTzRYhkg==
X-Google-Smtp-Source: APXvYqx/szkVU3xnR6S7kaiRH8PbEblL2+ypiIKPes+go0u6FfiNrftcFSirfXeFVHDYuf+DexALbQ==
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr8268613qtt.154.1576779913587;
        Thu, 19 Dec 2019 10:25:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l19sm2098280qtq.48.2019.12.19.10.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 10:25:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ii0U3-0007Z2-SU; Thu, 19 Dec 2019 14:25:11 -0400
Date:   Thu, 19 Dec 2019 14:25:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191219182511.GI17227@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
 <20191120000840.GQ4991@ziepe.ca>
 <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 17, 2019 at 11:38:52AM -0800, Rao Shoaib wrote:
> Any update on my patch?
> 
> If there is some change needed please let me know.

You need to repost it with the comments addressed

https://patchwork.kernel.org/patch/11250179/

Jason

