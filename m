Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE77346458
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 17:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhCWQEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 12:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhCWQEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 12:04:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D3C061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4HJ0TdOQqrS46Mf4WzpMQNX/rEdZxjZxw68goxq39EU=; b=o44DLT5R2MB7MSM3BBZ7PiNRtn
        mfkAtHIQnTIbD2RHgbXbwiX7XL4vkKdkfgb5tAZiuwL94ay1NFhwfIvsvFELutMdo0/2Cbq//eMDY
        BJdMVN4NIHvA2rmENN40PN61jVtML5g/K8yaPYO1xr3z9HyOVfPpdY9IlRRIiCf8EFXnqW0g4qA+5
        l7nlV0aP6vtc4d391+9JBA6VG757r/dPdo142812b0qCh/y8q3f8bpwDFswreDBxC8K2B346Y1VH+
        M1bQWS6309DBRghTyNyHQKqS9zCoXx28zT7R+fTK9BbJS5gXtlnRie/oDQbyhJ6cMYT0lMPLeJ/Tg
        0nSBE1sw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOj1u-00AE1x-Ek; Tue, 23 Mar 2021 15:33:26 +0000
Date:   Tue, 23 Mar 2021 15:33:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323153314.GB2434215@infradead.org>
References: <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 12:24:39PM -0400, Dennis Dalessandro wrote:
> Completely agree. However the GPU code from nvidia is not upstream. I don't
> see that issue getting resolved in this code review. Let's move on.

In which case you need to stop wasting everyones time with you piece of
crap code base, because it is completely and utterly irrelevant.

