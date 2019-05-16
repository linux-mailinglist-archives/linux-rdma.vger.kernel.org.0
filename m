Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D03720BA9
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEPPy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 11:54:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41166 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPPy1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 11:54:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id g190so2555251qkf.8
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QfXe+A4IpbHxOAExs2r+LK5dsqhNZeWB4Xt963P8dik=;
        b=A3Ch5p1eX7Exr32u2moA5nbAFC8QXo2cRTWn/tSTsebKghOBw2bqb92eG0bTxHS2Q6
         MQxPtmWlcL0X6PuBGxmBgT/r/RMd0Cyo0wIic8ukldvDHsZzbDnAlZErFUWg5NA6jyv4
         No1W4rftkQz+3pp35Yd6WoYKXa3JNKPcSkVUlbhtxkLkIWE1UiGnoUfpJdELQ5EdaSln
         BbqDfL9xg7pefItl3z9E1eYZ97t9cWmu5Q1MF+sc+Dj4cTaDThVEfxGfUOz/TVQk/D5T
         n91POnAPet5LpMqmwuz2M7GjzuRFLG4pfSBtMvSFPhGxOn/AcvI2xGZk17Jlx1/LpeGr
         niAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QfXe+A4IpbHxOAExs2r+LK5dsqhNZeWB4Xt963P8dik=;
        b=FepFtpZH+srQYjxEAAEKok/NBVvlJAjv/8Go2HGodF4WblNAbnqKHsaBX652VhApuo
         vfoFyHxqn3cnkkIlVRKAtyg8lnEmRAP6z2HlfmO6qW1Xy4NFC7s/R8vxC5/oiBhmYoDp
         KjLJVfUmxskbOyvNO5fV42Pm3rAFG9CFkgoXTWxEBUYHeCAgMov2P90HoWnjMtpMwd9u
         AItM+p42202QoYt3WVbZiiHoWLIyv3kh0pO2QjoV1C/L9Gin7kK+254fFsIO8nndxvhv
         t+MNvXncSXTKYS07ybAkjZ7C7k1/uS7Zuqy0xil4XNNjrF39XOr18gLogzytLEHOenV4
         daPA==
X-Gm-Message-State: APjAAAUsjQJ1NP4Alo2GQycEUAi/eQ3ipjgMQzJqtAPE4QJIT/rx2LFU
        x+2vLBCOcdmZ/SR8TBdK0t0qMw==
X-Google-Smtp-Source: APXvYqxRYIfCJq1zSmgNvITN0fGEcxpeqVEI/dDTqiDYt/eTVMXuPUBzqpc5dKWqIX2ebw6mNg8Miw==
X-Received: by 2002:a37:4c02:: with SMTP id z2mr28125161qka.1.1558022066653;
        Thu, 16 May 2019 08:54:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id r16sm247285qkk.36.2019.05.16.08.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:54:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hRIi9-0002CT-Pn; Thu, 16 May 2019 12:54:25 -0300
Date:   Thu, 16 May 2019 12:54:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190516155425.GF22587@ziepe.ca>
References: <20190516154720.GE22587@ziepe.ca>
 <20190507161304.GH6201@ziepe.ca>
 <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <OF39E350A0.36B83BDF-ON002583FC.0053C32C-002583FC.0055FBFD@notes.na.collabserv.com>
 <OF8865413E.BEF32DF5-ON002583FC.0057236E-002583FC.00572374@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8865413E.BEF32DF5-ON002583FC.0057236E-002583FC.00572374@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 03:51:47PM +0000, Bernard Metzler wrote:
> 
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 05/16/2019 05:47PM
> >Cc: "Leon Romanovsky" <leon@kernel.org>, "Doug Ledford"
> ><dledford@redhat.com>, "linux-rdma" <linux-rdma@vger.kernel.org>
> >Subject: Re: iWARP and soft-iWARP interop testing
> >
> >On Thu, May 16, 2019 at 03:39:10PM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Doug Ledford" <dledford@redhat.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 05/07/2019 06:13PM
> >> >Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Bernard Metzler"
> >> ><BMT@zurich.ibm.com>
> >> >Subject: Re: iWARP and soft-iWARP interop testing
> >> >
> >> >On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> >> >> So, Jason and I were discussing the soft-iWARP driver
> >submission,
> >> >and he
> >> >> thought it would be good to know if it even works with the
> >various
> >> >iWARP
> >> >> hardware devices.  I happen to have most of them on hand in one
> >> >form or
> >> >> another, so I set down to test it.  In the process, I ran across
> >> >some
> >> >> issues just with the hardware versions themselves, let alone
> >with
> >> >soft-
> >> >> iWARP.  So, here's the results of my matrix of tests.  These
> >aren't
> >> >> performance tests, just basic "does it work" smoke tests...
> >> >
> >> >Well, lets imagine to merge this at 5.2-rc1? 
> >> >
> >> >Bernard you'll need to rebase and resend when it comes out in two
> >> >weeks.
> >> >
> >> >Thanks,
> >> >Jason
> >> >
> >> >
> >> I think I addressed all major issues of the current siw RFC.
> >> 
> >> Probably most important, it's now guaranteed that the remaining
> >> two objects (QP and MR) are kfree'd after return from the
> >> ib_devices free call. This makes it easier for future development
> >> of mid layers resource management, as Leon was pointing out.
> >> 
> >> All IDR usage is gone as well.
> >> 
> >> I removed the siw protection domain, since there is nothing
> >> siw specific to be stored within. I just keep a structure
> >> definition of 'struct siw_pd {struct ib_pd *base_pd}' to
> >> keep INIT_RDMA_OBJ_SIZE() happy. 
> >
> >? Really? I iwarp doesn't use a protection domain?
> 
> Aehm no, siw does not need any siw specific additions to the ib_pd.
> So there is no need to define any extra siw_pd besides of ib_pd.
> Except for the INIT_RDMA_OBJ_SIZE thing.
> 
> siw can just use struct ib_pd. It has all it needs...

So you are using the pointer value of the ib_pd to identify if a
MR/QP/etc are in the same PD?

Jason
