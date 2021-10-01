Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC6741EEDC
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhJANul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 09:50:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:20261 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhJANul (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Oct 2021 09:50:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="310981662"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="310981662"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:48:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="708625912"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:48:52 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWIu9-007SM6-Jz;
        Fri, 01 Oct 2021 16:48:49 +0300
Date:   Fri, 1 Oct 2021 16:48:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 1/1] infiniband: hf1: Use string_upper() instead of
 open coded variant
Message-ID: <YVcRwS+MZxMkpk8E@smile.fi.intel.com>
References: <20211001123153.67379-1-andriy.shevchenko@linux.intel.com>
 <256e577b57eb21555de96846d1ac4cfa3b8ee238.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256e577b57eb21555de96846d1ac4cfa3b8ee238.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 01, 2021 at 06:31:21AM -0700, Joe Perches wrote:
> On Fri, 2021-10-01 at 15:31 +0300, Andy Shevchenko wrote:
> > Use string_upper() from string helper module instead of open coded variant.
> 
> Perhaps these string_upper and string_lower utility functions
> should return dst not void so these functions could be used in
> output calls.

Perhaps.

-- 
With Best Regards,
Andy Shevchenko


