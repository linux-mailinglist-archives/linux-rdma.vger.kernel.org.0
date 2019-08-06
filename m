Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA03838D2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfHFSlx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 14:41:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45108 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfHFSlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 14:41:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so63786967qkj.12
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQGVkLXB5toM/nVdonWNrrg/ISb5iTUaELbHX1saiys=;
        b=FAAF4gQgDlRaWEY544iQVVdja6zrj2qSHsN0Xptv6LsRSKWOGK3hb1Qn8lP7wNqgtD
         CNVdAfGKph0ukzaV716uw19GrEKTR54tCTvKhV3uKsgwpUNDyt7DzwJlRHTuUSXatjXs
         nTdSqo6qbc2FPcBs4q1OEVr+lHALizflmtA5yaFulvGC8PJezv1kSPbyFRQuEBRRwlYe
         U0DAgIU9DQjpzvNwNygdc2pO155tW6vwikMNbU/a+8EHbTF2mTvk/cmh8lH7/iL3Yy6q
         pXdxcf5SVGBeDBahwo/IbWnmi2jWYOCGjRVLTFjGhvx8zxXY4jVTsh7DiEshWkPKiSWx
         GMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQGVkLXB5toM/nVdonWNrrg/ISb5iTUaELbHX1saiys=;
        b=UGTOgSBXIsL+xvwbPtRduqrtjEMcmwmZPElGCOzgTNBpw7SCkEFTWYHghO+6eP/AW6
         0XWgR+gvGJh2H96r2zKhWLiIyBGhj52UsX1qaJ/0IzTIF0KSezsczbQeop9pdBpKRKvB
         cvuljbGG/DzC59SqrIMZ+XIK3q/U04Uj9DOIzJhCZsA5tzKnOKzaIq1mQpZwysAPg7vL
         Hl4r8XauF7oN6rei4MlPiZWOE7U7Ld86sy0ZcINkl4DX0tS21YpSBgYSoITkqNy0fBjJ
         xfRIu2zFwRlO/PJwT+ZsWjniEnA8/d+o0uD26RM6gYqbq7GLsSkOrUW+/3LMXQ9s9Spc
         45vw==
X-Gm-Message-State: APjAAAWSAIXq3gx7SV9VNvsZgOBdp5cN2aPLl58qfwcJWfu575frvVg0
        l3USfKIKshFXBgyQDXQXirKnItEbIhI=
X-Google-Smtp-Source: APXvYqxB5MtNU8vW2dGtPsacjPLUly3EZcWUBzobtHoTGsNQxPaGNlyPN9cz7jy+cP+uADf+JeXoTg==
X-Received: by 2002:ae9:e8d6:: with SMTP id a205mr72525qkg.241.1565116884711;
        Tue, 06 Aug 2019 11:41:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t26sm47214562qtc.95.2019.08.06.11.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 11:41:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv4Oh-0004Oy-8n; Tue, 06 Aug 2019 15:41:23 -0300
Date:   Tue, 6 Aug 2019 15:41:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Message-ID: <20190806184123.GT11627@ziepe.ca>
References: <20190728083749.GH4674@mtr-leonro.mtl.com>
 <20190729074612.GA30030@chelsio.com>
 <20190805110652.GB23319@chelsio.com>
 <20190806080902.GS4832@mtr-leonro.mtl.com>
 <20190806094849.GT4832@mtr-leonro.mtl.com>
 <20190806110812.GA6109@chelsio.com>
 <20190806111317.GV4832@mtr-leonro.mtl.com>
 <e94a97412c260616c8bd27d9dd361e496f15c67a.camel@redhat.com>
 <20190806153513.GA6210@chelsio.com>
 <1243687059f6579fd5bc6c95192f8470dc19dc44.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243687059f6579fd5bc6c95192f8470dc19dc44.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 11:55:22AM -0400, Doug Ledford wrote:
 
> I did a quick search on EBay (which is where I know a lot of people go
> to get dirt cheap prices on stuff like old cards to build their home
> networks with) and it didn't really turn up much in the way of cxgb3
> gear.  There was plenty of gear that would use the cxgb4 driver instead.
> So, I'm more on board with removing this driver now.

I dislike the cxgb3 driver mostly because it is substantially similer
to the cxgb4 driver and every fix has to be done twice.

So lets drop it

Jason
