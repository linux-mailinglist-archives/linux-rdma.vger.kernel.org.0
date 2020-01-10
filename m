Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033F51370E8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgAJPP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:15:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33565 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAJPPZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:15:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so2159255qkc.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lZPt4j3hF4vUAIVn/dD1UkWYns1dYb9oXxhrMUCGtf8=;
        b=FbrsBjs+4QSuCqCU7tRRp7pU1umAa8POdrw50qnlRt//0cqg0vfQMcozrVQPKyFIo6
         qd3SK7xoU/vnmQL6Nu+nP/0DFXAh2UU8v+QesVHeobkSrrOPFyY0JNrRxHiab4mkzf61
         snyc5NOLtVvgc1JAbnxZ8078BVC1QHSy5aRODfRdtIEwtQNCrwwvjbTybdXTkY0O+eKl
         VvXlts3Eem618MhcfGL2RF9YC6Sn4xQepVYU1iTzgoD0s8RV680Q0NCEtpMFawSd42OA
         EcO2Q3Tc99bUoGGuP4aoEtuLLVnG0l29NZGqw1eXt1abqfk3/tb7z9cg0EnViqbl1PZd
         scmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZPt4j3hF4vUAIVn/dD1UkWYns1dYb9oXxhrMUCGtf8=;
        b=kOj6uIhPJn4y5lAQoLw2ljWJumVBkvwp7KljjHUu2Q+7LXyojjYGuWnUR9iwopTrZT
         JXd0lSX0MvsuVSOCveNXrtvR+j4Nyrbk5Tj/qKLQBep/k9dEPgu3SaTXDbeszMJkJKw1
         iGCjf2+u02J6iRBg/FeDcFlnJHxo34wUdmhZz0H0Ctqwwaen5EbN3dqSzNjveP+nD+Px
         E0zt4iFV4ZdTXxCXObkmZONFugjSZHdMlyparhxBKsRus7dd1dr39L4/2z9HB8mmZgBq
         FJQmZbe/UGWR1yfgCndMjySfSxvt7JVeSPvZlK4f5eD8TFHKz15FbqC2eCxV1VGUDQvl
         5kbg==
X-Gm-Message-State: APjAAAVBnZNbLanCP4ASt+h/LUAmmfKVkHNJSvsnmGGp08GCIGh3bSv8
        uyuUFpL5mZ/HGFS+j1E+wWkQb20VfEI=
X-Google-Smtp-Source: APXvYqzIm4Bq/aIDDou6IIG3B7ugoisqCmyP6ZY63X+vnjGRI+wjsFjVkz/faBSlY91r3vN9Ulu2gQ==
X-Received: by 2002:ae9:dc82:: with SMTP id q124mr3691508qkf.20.1578669324891;
        Fri, 10 Jan 2020 07:15:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d9sm1105077qth.34.2020.01.10.07.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 07:15:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipw0R-0008MS-Up; Fri, 10 Jan 2020 11:15:23 -0400
Date:   Fri, 10 Jan 2020 11:15:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/9] Clean ups, refactror, additions
Message-ID: <20200110151523.GA32082@ziepe.ca>
References: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 06, 2020 at 08:41:37AM -0500, Dennis Dalessandro wrote:
> These patches add some recactoring and code clean ups to make things more
> organized. There is a performance optimization and new counter/debugging stats
> added as well. The new "API" that is added is a driver internal API not an
> actual "API" that is exposed to the outside.
> 
> 
> Grzegorz Andrejczuk (3):
>       IB/hfi1: Move common receive IRQ code to function
>       IB/hfi1: Decouple IRQ name from type
>       IB/hfi1: Return void in packet receiving functions
> 
> Mike Marciniszyn (6):
>       IB/hfi1: Move chip specific functions to chip.c
>       IB/hfi1: Add fast and slow handlers for receive context
>       IB/hfi1: IB/hfi1: Add an API to handle special case drop
>       IB/hfi1: Create API for auto activate
>       IB/hfi1: Add software counter for ctxt0 seq drop
>       IB/hfi1: Add RcvShortLengthErrCnt to hfi1stats

Applied to for-next, thanks

Jason
