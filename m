Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F624607A4
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Nov 2021 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358331AbhK1QoH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 28 Nov 2021 11:44:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:22927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358420AbhK1QmG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Nov 2021 11:42:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="236080093"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="236080093"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 08:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="539733855"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2021 08:38:50 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 08:38:49 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX602.ger.corp.intel.com (10.184.107.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 18:38:47 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2308.020;
 Sun, 28 Nov 2021 18:38:47 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "OFED mailing list" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mei: Remove some dead code
Thread-Topic: [PATCH] mei: Remove some dead code
Thread-Index: AQHX16z+MGID8V6pdUm1z2bNCeUOWqv/oKGAgBlBgNCAABWpAIAARYjg
Date:   Sun, 28 Nov 2021 16:38:47 +0000
Message-ID: <15b253e2abd049e6a9ebb4efafc10292@intel.com>
References: <3f904c291f3eed06223dd8d494028e0d49df6f10.1636711522.git.christophe.jaillet@wanadoo.fr>
 <80B25490-FE92-420E-A506-C92A996EF174@oracle.com>
 <17d6896a6abf49138556e34cb426d575@intel.com> <YaOSQrGqogbFGAqJ@kroah.com>
In-Reply-To: <YaOSQrGqogbFGAqJ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Sun, Nov 28, 2021 at 11:12:33AM +0000, Winkler, Tomas wrote:
> >
> > >
> > >
> > > > On 12 Nov 2021, at 11:06, Christophe JAILLET
> > > <christophe.jaillet@wanadoo.fr> wrote:
> > > >
> > > > 'generated' is known to be true here, so "true || whatever" will
> > > > still be true.
> > > >
> > > > So, remove some dead code.
> > > >
> > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > ---
> > > > This is also likely that a bug is lurking here.
> > > >
> > > > Maybe, the following was expected:
> > > > -	generated = generated ||
> > > > +	generated =
> > > > 		(hisr & HISR_INT_STS_MSK) ||
> > > > 		(ipc_isr & SEC_IPC_HOST_INT_STATUS_PENDING);
> > > >
> > > > ?
> > >
> > > I concur about your analysis, but I do not know the intent here.
> > Your fix  is okay, I can ack that patch.
> 
> Is that an ack of this patch?  If so, please provide that...
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
Thanks
Tomas

