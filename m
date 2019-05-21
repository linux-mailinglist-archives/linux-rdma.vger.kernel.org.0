Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA424AB4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEUIru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 04:47:50 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38790 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfEUIru (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 04:47:50 -0400
Received: by mail-ed1-f52.google.com with SMTP id w11so28150892edl.5
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SgkbQriplz2QtZ+MXvt/Ys6seoNBGxXtt8BjyawrLsE=;
        b=f9MyEvLFo+oU5rWIcB1yaXnI3t6bXQ5haj2v+Y1zH0ga/muDrAPYKt0KoGu2ld4Ob2
         I6qZX/MOjuhl7amz7xgnwKiPSByviTHBmtLLcRcUfxpNaDr6o9uq4+slqbsOZ07h51pT
         mMzPWiAtUinFc1gH2fbju8o9yuwS/NaBVk/Xy02Af4NvuIsrFzeMlnpPEKipMb00IlIj
         7NXZWrV1dMiArWaUfLtza2M/zTUXW4y7OSxAxQAMJdbNuN1U78rycJNfx7+Z6HUrUVzj
         XFxhXyZQR/PiHsBDJV96UfRryh2/4usvzQEalJxt7HRdPNSUYd4Msr4ofq41jsthoMpN
         JHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SgkbQriplz2QtZ+MXvt/Ys6seoNBGxXtt8BjyawrLsE=;
        b=OHHFHKFxBfmqFag45Tvu7ODba562bVQuhdJM4VPdwJ/VrX33JVDXp7GXcX3O5RhvGK
         Q5flqLKN1E82XPXC0YrmxZpDHCse5OndLlzbADdxzaAB0icKSrIf1x5W7m5RdEkANFDw
         A0wFjwsOmdwaQg2paDoDogoFvli2iyHDcnDxs3zePYA+ECCkbImZ33DEuLIp+VEjr3cQ
         Llx/0ULLcolFHS7YpvGYxyq4sIRYZ9CFzz25ldreIMTiV6/wWsHjDnC8DsqY7bV4BU1b
         WyRfgdxm0xoaAuceoRJzOV7QM01KqjaRZmY4/iBgGAEaIzyw749jocdaird/0H5nsYjx
         4drg==
X-Gm-Message-State: APjAAAWMOypRBSZ09YP5cmRCYI1jp5oHOwaX4n7wxbemEZCJMB2jmcsz
        2Qx41uIcnwx9BMwT7ZIEBbwWUw==
X-Google-Smtp-Source: APXvYqyfQLxLkOOY7XWyGeeueMoMw2LZ3H/l/k35keCovkpbBHtPbGAJkLy05qt2aa51uZkdXCrfrQ==
X-Received: by 2002:a50:f5ad:: with SMTP id u42mr81154055edm.17.1558428468760;
        Tue, 21 May 2019 01:47:48 -0700 (PDT)
Received: from fiftytwodotfive ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id l24sm3453982ejp.54.2019.05.21.01.47.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 01:47:48 -0700 (PDT)
Message-ID: <6b6041189eafcf9a067ccec5ffcb6711c7615a70.camel@cloud.ionos.com>
Subject: Re: rdma-core debian packages
From:   Benjamin Drung <benjamin.drung@cloud.ionos.com>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Date:   Tue, 21 May 2019 10:47:47 +0200
In-Reply-To: <20190517182129.GA5822@mtr-leonro.mtl.com>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
         <20190517182129.GA5822@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am Freitag, den 17.05.2019, 21:21 +0300 schrieb Leon Romanovsky:
> On Fri, May 17, 2019 at 09:14:13AM -0500, Steve Wise wrote:
> > Hey,
> > 
> > Is there a how-to somewhere on building the Debian rdma-core
> > packages?
> 
> There buildlib/cbuild script exactly for that.
> 
> 0. Install docker.
> 1. Commit your changes which you want to package.
> 2. ./buildlib/cbuild build-images supported_os_from_the_list
> 3. ./buildlib/cbuild make supported_os_from_the_list
> 4. ./buildlib/cbuild pkg supported_os_from_the_list
> 5. See RPMs or DEBs in ../
> 
> Repeat 3 and 4 till you will be satisfied with result.

If you don't want to use docker, you can build it locally with:

dpkg-buildpackage --no-sign -b

and you probably have to install the build dependencies before:

sudo apt build-dep rdma-core

Afterwards the .deb files are one level above. You can upgrade the
packages with:

sudo debi --upgrade

-- 
Benjamin Drung
System Developer
Debian & Ubuntu Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
E-mail: benjamin.drung@cloud.ionos.com | Web: www.ionos.de

Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim
Weiss

Member of United Internet

