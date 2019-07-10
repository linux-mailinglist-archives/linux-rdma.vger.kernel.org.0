Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447E464B51
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfGJRRY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:17:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:19401 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfGJRRY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 13:17:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 10:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="341132920"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2019 10:17:23 -0700
Date:   Wed, 10 Jul 2019 10:17:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in
 rvt_create_cq
Message-ID: <20190710171722.GB5072@iweiny-DESK2.sc.intel.com>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <20190709230552.61842-1-natechancellor@gmail.com>
 <20190710170322.GA5072@iweiny-DESK2.sc.intel.com>
 <20190710170711.GA80444@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710170711.GA80444@archlinux-threadripper>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 10:07:11AM -0700, Nathan Chancellor wrote:
> On Wed, Jul 10, 2019 at 10:03:23AM -0700, Ira Weiny wrote:
> > What version of the kernel was this found on?
> > 
> > I don't see the problem with 5.2.  AFAICS there is no 'err' in the function
> > scope and the if scoped 'err' is initialized properly on line 239.
> > 
> > Ira
> > 
> 
> $ git describe --contains 239b0e52d8aa
> next-20190709~84^2~57
> 
> I should probably be better about adding 'PATCH -next' to my patches,
> sorry for the confusion!

Ah I see it now...  Sorry I was just not up to date on the rdma tree.  Sorry
about the noise.

Thanks,
Ira

> 
> Cheers,
> Nathan
