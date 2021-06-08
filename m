Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBB39FC78
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhFHQ1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 12:27:31 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:40188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232790AbhFHQ1b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 12:27:31 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6DCA0838436D;
        Tue,  8 Jun 2021 16:25:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 02CA52351F4;
        Tue,  8 Jun 2021 16:25:35 +0000 (UTC)
Message-ID: <16b30bff1b1403192f18f110ac83451d4f7d5bc1.camel@perches.com>
Subject: Re: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
From:   Joe Perches <joe@perches.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 09:25:34 -0700
In-Reply-To: <38e0a7b9c19543c2aee679bdd346c5a9@intel.com>
References: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
         <d41c5503b5b74996af3f3c1853a67935@intel.com>
         <e3242b18d12db4bff77127d82d5e788b7712035a.camel@perches.com>
         <7bc8c264a70a4026b3bc7d9edd9e8945@intel.com>
         <6147b2a2a5992525482f2cf61d2939b110062d8c.camel@perches.com>
         <38e0a7b9c19543c2aee679bdd346c5a9@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02CA52351F4
X-Spam-Status: No, score=-1.90
X-Stat-Signature: bimw4w616k4ikzyazmjy53jugat1bzct
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19wFIxY6KhBGch1bjAwEL7hXvJ1AO6Tnyk=
X-HE-Tag: 1623169535-753571
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2021-06-08 at 16:18 +0000, Saleem, Shiraz wrote:
> > > Looks reasonable to me. Wondering if irdma_update_stats should
> > > also use your IRDMA_STAT macro.
> > 
> > Probably, and it could really a macro or two of its own.
> > 
> > And it looks like that block has it's own copy/paste defects.
> > 
> > Maybe:
> > ---
[]
> > +#define irdma_update_stat(index, var, size)				\
> 
> Maybe var --> name. Other than that looks good.

Just a suggestion.  Do what you want with it.

And also the field name/MACRO mismatches are a bit odd at best.

I'd rename one or the other to match.

> +     irdma_update_stat(IP4TXFRAGS, ip4txfrag, 48);
[]
> +     irdma_update_stat(TCPTXSEG, tcptxsegs, 48);
[]
> +     irdma_update_stat(RDMAVBND, rdmavbn, 48);


