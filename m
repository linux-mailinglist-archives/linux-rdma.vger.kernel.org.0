Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91541A3E5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhI0XsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 19:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238144AbhI0XsJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 19:48:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D989361156;
        Mon, 27 Sep 2021 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632786390;
        bh=aNC//vqVY8KVmPtHG5FpYt+23bSanJvozKpeda/rcIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUampo6u68kBohIQl/uMGU1hXfl5Sebi2Je3IssjVo1fsDq4h3rqzKVtuGEf1Vo+N
         vNlbKOzyCIyJrYvhCwSXxmB7GgengD2tExuK/TXNnDkPt/YgJi34UqkPPYJP3a/Chq
         69D86o/3gHrU+UjE50DlsxsoEVFfFw/u+iyuVTFMCbmJeGOCO3kJl5gyy7eZxRsAxL
         DoRRjLxM6qXTBiiYSt/QtUlnYWRJFTQ4xHxYSEceuYF1vEeN/TIfcb5GlUP0CIMciK
         4Vl1yh2pmPKAchMHesQFD+P+AV2zVbUrutb/erVU1kX7ee9K45TuGFd5GkZ5xeYEBA
         uLGoTFnQDl0HQ==
Date:   Mon, 27 Sep 2021 18:50:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hfi1: Use struct_size() and flex_array_size()
 helpers
Message-ID: <20210927235030.GA196756@embeddedor>
References: <20210927225333.GA192634@embeddedor>
 <20210927233650.GA1629838@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927233650.GA1629838@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 08:36:50PM -0300, Jason Gunthorpe wrote:
> 
> Applied to for-next, thanks

Thanks, Jason.
--
Gustavo
