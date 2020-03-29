Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAED196E7A
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgC2QcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 12:32:16 -0400
Received: from mx.sdf.org ([205.166.94.20]:63508 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgC2QcP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Mar 2020 12:32:15 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TGVvPV009144
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 16:31:57 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02TGVuVO017489;
        Sun, 29 Mar 2020 16:31:56 GMT
Date:   Sun, 29 Mar 2020 16:31:56 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Jason Gunthorpe <jgg@ziepe.ca>, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
Message-ID: <20200329163156.GB4675@SDF.ORG>
References: <202003281643.02SGhN9T020186@sdf.org>
 <20200329143621.GF20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329143621.GF20941@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 11:36:21AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 08:21:45PM -0400, George Spelvin wrote:
>> There's no need to get_random_bytes() into a temporary buffer.
>> 
>> This is not a no-brainer change; get_random_u32() has slightly weaker
>> security guarantees, but code like this is the classic example of when
>> it's appropriate: the random value is stored in the kernel for as long
>> as it's valuable.
> 
> The mechanical transformation looks OK, but can someone who knows the
> RNG confirm this statement?

You might find commit 92e507d21613 ("random: document get_random_int() 
family") informative.

> Many of these places are being used in network related contexts, I
> suspect the value here is often less about secrecy, more about
> unguessability.

The significant difference is backtrackability.  Each get_random_bytes()
call has a final anti-backtracking step, to ensure that the random number
just generated cannot be recovered from the subsequent kernel state.
This is appropriate for encryption keys or asymmetric keys.

The get_random_{int,long,u32,u64} functions omit this step, which means
they only need one ChaCha20 crypto operation per 64 bytes of output,
not a minimum of one per call.

One good way of distinguishing the cases is to look for calls to 
memzero_explicit().  If you need to ensure the random bytes are securely 
destroyed, you need antibacktracking.  If your application doesn't care if 
anyone learns your session authentication keys after the session has been 
closed, you don't need it.
