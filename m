Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB434643D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 17:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhCWP73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhCWP7Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 11:59:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A402C061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZ1xvRQ0+UZZOE62fXJIWDOpjQEoqDksCxNPvm51xhA=; b=J6/6HMKhwKlz79ICzO7O5KzAc+
        Bx/ErA1+ihU+2HMOwxe/EzSQ3p3xyEY8NV2FzZyEsjMkg1QAoKaPKl35E7DpcWLt/QSgQkh0sPHxN
        SHQJoVEnLRIEAXk3ZAHVw1Dmv/2c67uj16QfO69pjiUObb9ZjcfioJhDVXMLTZ3RQSwWUybVS2ROQ
        lsr65K2qyHTtI4+N4THmOx7l7wg6bCO+PBhYenrNj8wVKxd56B4skH12bmX4As3pCj3h+Gc0dAo1J
        WsihuPw79NpaMi18e4EClS6e3by+efsHZbNjXbHZF0oB+5DCHFkUS14hf5+/ENnyoFFbJkiFaoiTY
        kcLYSqwQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOizR-00ADxx-Oi; Tue, 23 Mar 2021 15:30:50 +0000
Date:   Tue, 23 Mar 2021 15:30:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323153041.GA2434215@infradead.org>
References: <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 10:57:20PM +0000, Rimmer, Todd wrote:
> We'd like advise on a challenging situation.  Some customers desire NICs to support nVidia GPUs in some environments.
> Unfortunately the nVidia GPU drivers are not upstream, and have not been for years.  So we are forced to have both out of tree
> and upstream versions of the code.  We need the same applications to be able to work over both, so we would like the
> GPU enabled versions of the code to have the same ABI as the upstream code as this greatly simplifies things.
> We have removed all GPU specific code from the upstream submission, but used both the "alignment holes" and the "reserved"
> mechanisms to hold places for GPU specific fields which can't be upstreamed.

NVIDIA GPUs are supported by drivers/gpu/drm/nouveau/, and your are
encourage to support them just like all the other in-tree GPU drivers.
Not sure what support a network protocol would need for a specific GPU.
You're probably trying to do something amazingly stupid here instead of
relying on proper kernel subsystem use.
