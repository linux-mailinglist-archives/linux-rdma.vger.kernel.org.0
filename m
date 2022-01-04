Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7C483E5F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiADInb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiADIna (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 03:43:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57FC061784;
        Tue,  4 Jan 2022 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FtthXaRHeFfdIo190f8/8Lo0bGBFNYRD9xADwfdj8vA=;
        t=1641285810; x=1642495410; b=ajQGG3G7jJDrylAk8ZijJ9Kkrtq0Qx+i4QRfPOWOC+G4TKc
        z0Yv0WHO8taw5aGsXP8qbAMHeoT33ayfATfRE/7uPksg0oqsEWcpKcYaJ+j0z1dSN6DLKUvmAgGqc
        4c0esAjagTevPGJS7ua6kKMEzQdOAPG3bfZJYtnGNdxB5OAUbxeEkn+lUWVXqbW7Js01YVEONxBXU
        vjLEOiQjpyoH0aUrIPnuwHjAQH+1kY9QcEofWVcDAn6eg07zDAoeTvsG97m326W1nhGxYqiPoGs7I
        7/JS1C4Vz8zBChFRd/ylXFqJ9iAJ757Xs6Q40AS/GksH0L8smby9cfi+WeUiDiNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4fPa-001hNX-Gk;
        Tue, 04 Jan 2022 09:43:19 +0100
Message-ID: <21fc9b66d15300b19e74b7992baa152173a19162.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-rdma@vger.kernel.org, linux-um@lists.infradead.org
Date:   Tue, 04 Jan 2022 09:43:17 +0100
In-Reply-To: <6c083f0d-4fea-6339-71ca-6e8fb524e1c0@cambridgegreys.com>
References: <20220102070623.24009-1-rdunlap@infradead.org>
         <20220103230445.GA2592848@nvidia.com>
         <50fa4eca-ce74-431f-8497-273d2c5956f2@infradead.org>
         <6c083f0d-4fea-6339-71ca-6e8fb524e1c0@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2022-01-04 at 08:03 +0000, Anton Ivanov wrote:
> > 
> > > Why are you trying to make a HW driver compile on UML? Is there any
> > > way to even use a driver like this in a UML environment?
> > 
> > I'm just trying to clean up lots of UML build errors.
> > I'm quite happy just making the driver depend on !UML.
> > 
> > UML maintainers, what do you think?
> > 
> > Thanks again.
> > 
> 
> I would suggest that we just !UML this driver.
> 
Agree, unless some of the maintainers of this driver actually wants to
build simulation for it for testing or something, it's almost certainly
completely useless.

After all, the reason I enabled PCI on UML was to be able to test - in
simulation - PCI driver code in UML... Most certainly nobody wants to do
that here, so it's pointless to let the driver be compiled.

OTOH, as Christoph points out, that seems like a band-aid for some
really strange code, but it's probably the easiest way to get the build
issue fixed in the short term.

johannes
