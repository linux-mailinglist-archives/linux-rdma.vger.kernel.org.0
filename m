Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B1B1581E4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJSAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 13:00:35 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:55343 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJSAf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Feb 2020 13:00:35 -0500
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01AI0PWr026391;
        Mon, 10 Feb 2020 10:00:26 -0800
Date:   Mon, 10 Feb 2020 23:30:24 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     dledford@redhat.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-review/for-rc/for-rc] RDMA/siw: Remove unwanted
 WARN_ON in siw_cm_llp_data_ready()
Message-ID: <20200210180022.GA23283@chelsio.com>
References: <20200207115209.25933-1-krishna2@chelsio.com>
 <20200207141820.GF4509@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207141820.GF4509@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Friday, February 02/07/20, 2020 at 10:18:20 -0400, Jason Gunthorpe wrote:
> On Fri, Feb 07, 2020 at 05:22:09PM +0530, Krishnamraju Eraparaju wrote:
> > Warnings like below can fill up the dmesg while disconnecting RDMA
> > connections.
> > Hence, removing the unwanted WARN_ON.
> 
> Please explain why it the code is correct to take this error
> path. Bernard clearly thought this shouldn't be happening
> 
> Jason
As part of iSER multipath testcase, target(iw_cxgb4) responds with MPA reject
to initiator(SIW) when iw_cxgb4 resources gets exhaused(expected as per
testcase), then SIW performs the connection teardown and dissociates
'cep' from tcp socket 'sk'. And if any "data_ready" notifications from
TCP stack after this connection teardown will hit WARN_ON() in
siw_cm_llp_data_ready().

Bernard, is this WARN_ON() useful to identify any error conditions?

Thanks,
Krishna.
