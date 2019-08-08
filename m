Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C78660D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHHPji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 11:39:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45950 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfHHPji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Aug 2019 11:39:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so19185232qtp.12
        for <linux-rdma@vger.kernel.org>; Thu, 08 Aug 2019 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X6YS8ya1J6071EZ/AKpEMRMC3Fa+C8ZpGoljqt1XgjE=;
        b=PPV+Oj7l2dptBUva36tovPqDSU9jRcHmcAkm1qAhTb1zgDsoJUol88Bwad25tAwJ71
         B+XWEAWG2YpwoSJPsQh58p/kNKO2oZ4xNtOrWfsqJtP99pYKa28WVB4zvPrnyST3YMh6
         xWG7MhZMq1863Fxg1cgjjsK7adop4zFR+HZFScGGIgoVCXPMrdvYHxiquSd4vDDjoiM0
         L7ahHdI4o2PFWSNlSxw+6NmPv/CjGWIeHXbv0acYfjfPsUnDg6Ydu5D8Lcq0064qfIoN
         wC8gSE9iawzb2lxpprdrSv3Mv8OOPneViubs3c8PHT2Q2ihImI2SKSjKuvZmc8kiB0zU
         vyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X6YS8ya1J6071EZ/AKpEMRMC3Fa+C8ZpGoljqt1XgjE=;
        b=dUX2OpenMU6z1V9RevsnqJdlhRwHb5SprDIepy14eZozqDm8NHr9Wz4fThNzHw0yNh
         YOQ6CekbAn8QpMy3qbfu+AL/II/645AawqgWn+r36z2OExXPDjZx6C0OntjNwQ9iDPls
         E334zwwSWnObzZptjK52Bs6DLL21Pd3pvfE1JAdoqtDy7SQ2g1OpXd8E6Yce1wDp1IqC
         JGCucLL9NVuqzZfpUc+bMOofGB1tbjA41DV/ZPehlwQQ2JDjAfApCqf5+aTRWV2M6YzR
         T0I3no5x1hxuolDfgvkpHGdi53l+rTedq1sL0wmI+mS4vMnF7PB2OGN0iyFTT7gQcjT3
         TM9w==
X-Gm-Message-State: APjAAAXITvcgnAd3bVirFO5iWCt4U7aUieTVFFb+DMjsOHta/niPDqRK
        nQRYCB27VXIvh3bqRd6mp0dy3g==
X-Google-Smtp-Source: APXvYqxe1wOsyHZLQbUvwdhEEgFDbKZcl64VrNpJs01PICiqhMATz8/e0hY7PMolxISCbsa37rOC+g==
X-Received: by 2002:a0c:b159:: with SMTP id r25mr13297879qvc.219.1565278777191;
        Thu, 08 Aug 2019 08:39:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a135sm42187210qkg.72.2019.08.08.08.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 08:39:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvkVs-0002er-CX; Thu, 08 Aug 2019 12:39:36 -0300
Date:   Thu, 8 Aug 2019 12:39:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32
 bit size to remove 64 bit architecture dependency of siw.
Message-ID: <20190808153936.GC1989@ziepe.ca>
References: <20190806163901.GI11627@ziepe.ca>
 <20190806153105.GG11627@ziepe.ca>
 <20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
 <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
 <OF3F75D9B9.20A30B62-ON0025844E.005D311D-0025844E.005D8CF2@notes.na.collabserv.com>
 <OF3FCBE885.788F61B5-ON0025844F.002DF52F-0025844F.0061F0FB@notes.na.collabserv.com>
 <OF960ACAF9.E44A6FA7-ON00258450.003C6AE7-00258450.004E8C35@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF960ACAF9.E44A6FA7-ON00258450.003C6AE7-00258450.004E8C35@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 08, 2019 at 02:17:57PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Jason Gunthorpe"
> ><jgg@ziepe.ca>
> >From: "Doug Ledford" <dledford@redhat.com>
> >Date: 08/07/2019 08:53PM
> >Cc: linux-rdma@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: [PATCH 1/1] Make user mmapped CQ arming
> >flags field 32 bit size to remove 64 bit architecture dependency of
> >siw.
> >
> >On Wed, 2019-08-07 at 17:49 +0000, Bernard Metzler wrote:
> >> 
> >> It hurts, but I did finally setup qemu with a ppc image to check,
> >> and so you are right!
> >> 
> >> ...
> >> 
> >> #ifdef __BIG_ENDIAN__
> >> 
> >> seem to be available in both kernel and user land...
> >> 
> >> But, general question: siw in its current shape isn't out
> >> for long, older versions from github are already broken with
> >> the abi. So, silently changing the abi at this stage of siw
> >> deployment is no option? It's a hassle to see an old mistake
> >> carried along forever with that #ifdef statement...no?
> >
> >I was thinking about that myself.
> >
> >This really hasn't been out long enough to completely tie our hands
> >here.  A point update to rdma-core will resolve any user side issues.
> >
> 
> What we are aiming at is ensuring backward compatibility
> for 64bit-BE architectures, which are using siw since this year.
> The community is likely of size zero. 
> I found it hard to find a machine, even in the ppc world, which
> let me test that BE thing. I ended up with an emulator. So I
> assume it is no real world issue to now just change the 64bits 
> flag into 32bits and add a 32bit pad for ABI compliance.

This seems reasonable to me, document all these details in the commit
message.

Jason
