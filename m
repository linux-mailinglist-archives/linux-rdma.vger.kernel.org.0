Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55EF84B54
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfHGMWs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:22:48 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:35579 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfHGMWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 08:22:48 -0400
Received: by mail-qt1-f170.google.com with SMTP id d23so88086762qto.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B4Yb79ZGGstMd+jP8eChmp77XeOx+EaO+Ee7twbUdXU=;
        b=gublBjvFr09Q67c99WFehGppJCPovytIrW5vR4rZ1YA5lzkEdooJiajbLWhq83fJvW
         /R+WiZlixseplC4u9ftlyBvd15m9d4j9gdBh1SDXY+W5n1fa43zisNS3IY/+bPcgsyyQ
         vODsTnHCjtsDyv4+MfMs0wxRvALd47GlJbdnpJ35v3wFqySayw3Lod1ZjHjdiDTU+DnS
         EsIMEoUWIlOI/N2S2I8yUkMLMKEEQuZrjzc6Uzf8tmnVZLiY5DPwx0H1x2U5bv1s2MNL
         bniVV2IiYbUcCQvhpgXTff8bXoaot6oSB8QzD1YsG9rYwTgOP2fAsdLgH/mt+XLkhYT7
         /65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B4Yb79ZGGstMd+jP8eChmp77XeOx+EaO+Ee7twbUdXU=;
        b=G1wo3zhAIftvlirFARcYz6tdAZcew25dilhwolXX/nyaYT+1X+eh1LCGQmj9eQ36IY
         dJ5u2w7BBZOPxwGlSwHMpRFIAZwMdeTaU2gMW+de0OgY5y2pOnJeAyDD5G0rAmNCWatZ
         RsS4DHBm/jMfhE3++HvsDXynz44PtTN0/98tNdwdtChXNktYuLIA005saG2yMS5rXDab
         BUNJkdI9t6QK/PMW3iXqNQ7qtULUb0advE6ZomZorA/hb40mwYVeH6Sg23SUQLfgHRv4
         UuoSHtuH3FYee44DhBGODymqIgR9jYgsMcr0VYF3meaKV0L2ZtvMsHiQZGOZ5bILkpBe
         Q+QA==
X-Gm-Message-State: APjAAAWWKW1iX15to5t0jPblziaI7B35Jb1Qn35J6ldhpDxI4sTV+Xmr
        wcV3wUBYQYWongDp5dZwNvzmkjE79UI=
X-Google-Smtp-Source: APXvYqzXgwuzL/0h/qNVFAmgOR++OsHIGS1AHWE+GD04Z99wrXijVAlTh+CTMy1L1D2TX1QyfbT1Dw==
X-Received: by 2002:ac8:60a:: with SMTP id d10mr7633062qth.31.1565180567478;
        Wed, 07 Aug 2019 05:22:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t26sm48572022qtc.95.2019.08.07.05.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 05:22:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvKxq-0001Cj-G1; Wed, 07 Aug 2019 09:22:46 -0300
Date:   Wed, 7 Aug 2019 09:22:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: v25.0 ninja install failure on pandoc-prebuilt using git tree or
 release tarball
Message-ID: <20190807122246.GD1557@ziepe.ca>
References: <CA+X5Wn75Lfh_i89sW1L+x1S3rnZsEGkzfNYju4woPvq0yCo=XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+X5Wn75Lfh_i89sW1L+x1S3rnZsEGkzfNYju4woPvq0yCo=XA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 11:45:21PM -0400, James Harvey wrote:

> As-is, building v25 from the git repo has a new build requirement of
> rst2man, which isn't documented in the release notes or in the readme.
> (On Arch, part of the python-docutils package.)  I haven't directly
> used pandoc or rst2man before, so I don't know if rst2man was added to
> be an alternative to pandoc, or ran in addition to it. 

Both are required.

> I looked at switching to the release tarballs (rdma-core-25.0.tar.gz),
> which of course has the prebuilt man pages.  I assume doing this
> should completely prevent needing pandoc and rst2man.  But, then
> "ninja install" fails from not finding
> "pandoc-prebuilt/32acf8c8016edc90e7adedc5be9caecd9b8abb3e", which I do
> see is not among the 81 directories in "pandoc-prebuilt/" in
> "rdma-core-25.0.tar.gz".  Were some of the necessary prebuilt files
> not included in the 25 tarball?

Hum, it will be hard to tell what is going wrong without knowing what
is in that file - if you have pandoc and rst2man installed then
build/pandoc-rebuilt should contain it.

Jason
