Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09462B6740
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 15:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgKQOUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 09:20:23 -0500
Received: from gentwo.org ([3.19.106.255]:36714 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKQOUX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 09:20:23 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 6A0B63F4C9; Tue, 17 Nov 2020 14:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 694F13F1C3;
        Tue, 17 Nov 2020 14:20:22 +0000 (UTC)
Date:   Tue, 17 Nov 2020 14:20:22 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jens Domke <jens.domke@riken.jp>
cc:     linux-rdma@vger.kernel.org
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <bbaa9827-fed4-492b-5c22-e543e8c69fbf@riken.jp>
Message-ID: <alpine.DEB.2.22.394.2011171418050.206345@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <bbaa9827-fed4-492b-5c22-e543e8c69fbf@riken.jp>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 17 Nov 2020, Jens Domke wrote:

> I have used ibacm successfully years ago (think somewhere in the
> 2013-2015 timeframe) but abandoned the approach because some
> measurements indicated that using OpenMPI with rdmacm had a big
> runtime overhead compared to using OpenMPI+oob (Mellanox was
> informed but I'm unsure how much has changed until now)

Mellanox does not support ibacm.... But ok. Thanks. Good to know someone
that has actually used it.

> > Is there something that can locally cache the results of the SM queries to
> > avoid additional requests?
>
> Not that I know of, but others might know better. Maybe try contacting
> Sean Hefty (driver behind ibacm) directly if he missed your email here
> on the list.


I have talked to Ira Weiny who wax the last one who did major changes to
the source but he does not know of any alternate solution.

> > We have tried IBACM but the address resolution does not work on it. It is
> > unable to complete a request for any address resolution and leaves kernel
> > threads that never terminate instead.
>
> Setting up ibacm was/is painful, maybe you could verify that it works on
> a test bed with lowlevel rdmacm tools to debug with ping-pong, etc.

That was done and the bug was confirmed. There is bitrot there in the MAD
communication layer.

> Furthermore, another thing I learned the hard way was that a cold cache
> can overwhelm opensm as well. So, if you deploy ibacm, you have to make
> sure that not too many requests go to the local ibacm on too many nodes
> simultaneously right after starting ibacm service, otherwise having all
> nodes sending numerous requests to opensm could timeout -> could be the
> reason for your stalled kernel threads.

Right But our cluster only has around 200 nodes max. Should be fine.

> (another explanation is obviously a bug in ibacm and/or incompatibility
> to newer versions of librdmacm or opensm or other IB libs)
>
> Sorry, that I cannot provide more specific and direct help, but maybe my
> pointers can help you solve the issue.

Thanks.

