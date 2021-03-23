Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C999346455
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhCWQER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhCWQEA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 12:04:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB2C061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CCOb34gpWzAIncU/WU2rIbnPH8S20IVhCdDaIp72dGw=; b=hSwRqsQpET1q/1upsQO0jGE12l
        TrK27Nc9iVHNODCo/PMOzBzkDew2In8KK1Z1ezmqtwln01Hl453YP3o5o+/F/UB4QADyKyXOA49kW
        DO/cqtZwVZ6VvrkXDoO9gzPynTAe6JVhPVvNb0/Xzg5t0EnkmPmr4MgS92I/BREsR1tIerfktmW5+
        ELk8vetz0hHLA5Cz9mZN7w4o29Y4rDXWs0fK/tF8d/BcEKeUrfb5vNuy6QyoyVI3W1D+HX90QEaVI
        SmpIMQhrHD7TIGZAIQzUPijaYsu+HoSkEHNVdq7EFJD7TCElGtIYO4uaToMZN6Q3Q5p5W57YvidIX
        H1XSSKjw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOj5D-00AECt-GT; Tue, 23 Mar 2021 15:36:41 +0000
Date:   Tue, 23 Mar 2021 15:36:39 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323153639.GD2434215@infradead.org>
References: <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 01:21:14PM -0400, Dennis Dalessandro wrote:
> No one is suggesting to compromise the upstream world. There is a bigger
> picture here. The answer for this driver may just be take out the reserved
> stuff. That's pretty simple. The bigger question is how do we deal with
> non-upstream code. It can't be a problem unique to the RDMA subsystem. How
> do others deal with it?

By ignoring it, or if it gets too annoying by making life for it so
utterly painful that people give up on it.
