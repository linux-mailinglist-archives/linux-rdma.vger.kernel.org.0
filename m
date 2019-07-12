Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB267484
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGLRp1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 13:45:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41435 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfGLRp1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 13:45:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so7009470qkj.8
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z5HbMzk+TNHcYVHCO/5rmn/u7ficHQ0wbbFTmo5UzU=;
        b=ntIle1vFd4ZRdhL76VdsyNncHbXMdq6YNaWmDXrUKzA+t8Vh0t4u+t7axMcNHs0iuw
         +6BMZPBIubJ/OADehqKIjDhkvwuy+nA1yXtaPdRNNCEGjETMn+QSWuolgrprj/tTsHV/
         wOa7AY/RdD5MwyK+uag+ltgfrIaM5XwVSVgBV2+w1C/cqFSKXbZIq9M6wdgGWt5IQ9ni
         BoHdbjyXjLcddyWoUDcw5j4m9hccSbEs9/iKYjJcUOOd3Y+roGowiR2ewSqn4OcsFLyS
         QqvMoOtBCOasiWF7sy+bSugWWJjPhsk0QBAdFofi25fIGvfj/bo3SBiCeWHAzhEV4Yts
         momw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z5HbMzk+TNHcYVHCO/5rmn/u7ficHQ0wbbFTmo5UzU=;
        b=LVpT6cMq8k57cv077it1M2hYDsPUVcx5FPEIyJnnI3iB29w7f8jSKoSFLxXmIQO5EB
         ZdCkZ2mYrcTJ3SqNglccPLQ27nBkQOMQNo/Ivk97wHEBw0HWqpSfR2PNPTrroeFDyVqz
         e8YVNUVcGhUG3oiJzieUVNzZF+RABemW4a5v9Q54/gwvJYiwms1EihZhbq65Z5HmalQ0
         LkYTaljIu3HRO0ykcHb0GvZfHalm+AoF16giNRTvwTNcm3IXBMuzMCKgN91K/ScPUUbZ
         HI00AF65Qb2bHVYY1E+HLQ8n3tGd93cCbN7S0fhViUNHbi1Avxj7L020zMQ4r0c4PKgZ
         SjWw==
X-Gm-Message-State: APjAAAUX6zOPHa/CEe3KZqh2drdU5n0zPD0saHCCDVw2OJqAFXuul+iV
        suq+Q4xgjlsC/3coUn+UfBnrmg==
X-Google-Smtp-Source: APXvYqxO7Pu7cyayLc2eUuHye7UyvHfBFgn42OETbQ3/0lzN915uNwmMT3yv7kbtcWLsGn4LaKpKig==
X-Received: by 2002:a37:6290:: with SMTP id w138mr6884162qkb.139.1562953526125;
        Fri, 12 Jul 2019 10:45:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w24sm3091129qtb.35.2019.07.12.10.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 10:45:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlzbp-0003rz-7O; Fri, 12 Jul 2019 14:45:25 -0300
Date:   Fri, 12 Jul 2019 14:45:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712174525.GM27512@ziepe.ca>
References: <20190712153243.GI27512@ziepe.ca>
 <20190712144257.GE27512@ziepe.ca>
 <20190712135339.GC27512@ziepe.ca>
 <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
 <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
 <OFAB0712BA.E95178B5-ON00258435.00611CBE-00258435.00611CC4@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFAB0712BA.E95178B5-ON00258435.00611CBE-00258435.00611CC4@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 05:40:43PM +0000, Bernard Metzler wrote:
 
> It is because there are two levels a CQ can be armed:
> 
>        #include <infiniband/verbs.h>
> 
>        int ibv_req_notify_cq(struct ibv_cq *cq, int solicited_only);
> 
> If we kick the CQ handler, we have to clear the whole
> thing. The user later again decides how he wants to get it
> re-armed...SOLICITED completions only, or ALL signaled.

Arrange it so only one of the two bits is ever set and do two
test-and-set bits when a SOLICITED CQE comes in?

Jason
