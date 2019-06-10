Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49A3B39D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfFJK7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 06:59:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40381 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388912AbfFJK7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 06:59:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so8692088wre.7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Uer6lNTQogYDPtgQx7Xvg5YjsemAhR0TAzBGBismyGk=;
        b=hTRdTbwrR3qx6GGWDnI/3SJ5QqEC8hxeOEiXYhG/c4RP9+WNDWK2QYR4EiVaeruoTY
         VVBkuRiicUrStZDXrLblR/USs+FIujtIXZd8ydhM67IWMJ8ZY44y2Dcxf6EOl04OqrUA
         rw1P43RcXCQtqlFafxNmX3f/jL7UDnl8c2MPQ+i47eXEv74c9+ADLraEQW0oU7CXHyjc
         lsPMyDLECjQcC6R0BIggTemEOEDA54xHHAg9KCQHb6Eqf4DwjgfH5Hl+NW+1cY676Iyi
         T/bUonNAv28/LgiNtFC1uLp57ozPJelHZkEIqCZJ26kRvQqeY3dA9XeB5wln5UnWS1Ak
         /1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Uer6lNTQogYDPtgQx7Xvg5YjsemAhR0TAzBGBismyGk=;
        b=Zh1s2OKwjru9H9GfQd53yJaPyPlOBQuKj4MkQrG/y4Fu5hiHrKHc85Zzq57ifTHpjn
         Q2GKAvsLoNac54yhUGZo/PbeBS4/SfsacTEuqvQxkqk57hzbvJ1Vw+eSvk+q0rAoFKN7
         TmDaR2WY5vAk5kZA+9YeJYyynA48WEuP46CnwjGFcd69T8X7UkCT5q61czRL9ALx24L3
         Dj5S8ZyGu8tHbxR09fUyT8DpAt/yjPywj1vpOzvUYaLvxDH8xZa002lKqi6u9R9S6Pgr
         VoYszxw2ozQCpd/OEBvRuFtsrqzwVxFa/xomnBHZxHukDtfjwtH03CIKSvsjSfZW0odq
         8LUA==
X-Gm-Message-State: APjAAAV3BlzNVv8dIx+YUEyhVs5/aptQxbT3yZht6/TQBwDK24j3lQTN
        RiSdVs14GI0tLsqD+P+m3iU=
X-Google-Smtp-Source: APXvYqxlm73bw2BeY0EG3T38qM0+9PvQEn8IFZPJSLPWJCZWjf8t4VKwrVsa1ZiwmvooXxpYcunH3w==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr25448831wrx.215.1560164373752;
        Mon, 10 Jun 2019 03:59:33 -0700 (PDT)
Received: from kheib-workstation (bzq-79-182-32-182.red.bezeqint.net. [79.182.32.182])
        by smtp.gmail.com with ESMTPSA id q20sm29324942wra.36.2019.06.10.03.59.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 03:59:32 -0700 (PDT)
Message-ID: <338cf9cde79ee9d734d8d854a342731e0da7e962.camel@gmail.com>
Subject: Re: [PATCH for-next] RDMA/ipoib: Remove check for ETH_SS_TEST
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date:   Mon, 10 Jun 2019 13:59:31 +0300
In-Reply-To: <20190607120952.GJ5261@mtr-leonro.mtl.com>
References: <20190530131817.6147-1-kamalheib1@gmail.com>
         <20190607120952.GJ5261@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2019-06-07 at 15:09 +0300, Leon Romanovsky wrote:
> On Thu, May 30, 2019 at 04:18:17PM +0300, Kamal Heib wrote:
> > Self-test isn't supported by the ipoib driver, so remove the check
> > for
> > ETH_SS_TEST.
> > 
> > Fixes: e3614bc9dc44 ("IB/ipoib: Add readout of statistics using
> > ethtool")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > index 83429925dfc6..b0bd0ff0b45c 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > @@ -138,7 +138,6 @@ static void ipoib_get_strings(struct net_device
> > __always_unused *dev,
> >  			p += ETH_GSTRING_LEN;
> >  		}
> >  		break;
> > -	case ETH_SS_TEST:
> 
> The commit message and code doesn't match each other.
> Removing this specific case will leave exactly the same behaviour as
> before, so why should we change it?
> 

The idea is very simple, no point of checking ETH_SS_TEST if the ipoib
doesn't support it.

> >  	default:
> >  		break;
> >  	}
> > @@ -149,7 +148,6 @@ static int ipoib_get_sset_count(struct
> > net_device __always_unused *dev,
> >  	switch (sset) {
> >  	case ETH_SS_STATS:
> >  		return IPOIB_GLOBAL_STATS_LEN;
> > -	case ETH_SS_TEST:
> >  	default:
> >  		break;
> >  	}
> > --
> > 2.20.1
> > 

