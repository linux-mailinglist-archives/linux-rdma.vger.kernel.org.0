Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F045D2C0942
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbgKWNFe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 08:05:34 -0500
Received: from gentwo.org ([3.19.106.255]:37544 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387581AbgKWMuc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 07:50:32 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 0D0423F198; Mon, 23 Nov 2020 12:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0A4DA3F09B;
        Mon, 23 Nov 2020 12:50:14 +0000 (UTC)
Date:   Mon, 23 Nov 2020 12:50:14 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
Message-ID: <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.22.394.2011231244492.272074@www.lameter.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 22 Nov 2020, Christopher Lameter wrote:

> > If you set acme_plus_kernel_only to one in said config file, you app will resolve the address using the kernel neighbour cache and the route resolution will go into the kernel and then "bounce" back  to user space and ibacm through NetLink.
>
> Have not seen that in the RHEL7.8 version of ibacm.
>

Got version 33.0 from Redhat with the option. Set it but ibacm still times
out when trying to contact the SM.

ib_acme says:

ib_acm_resolve_ip failed: Connection timed out


ibmacm.log says

acmp_process_wait_queue: notice - failing request
acmp_process_timeouts: notice - dest 192.168.50.39


