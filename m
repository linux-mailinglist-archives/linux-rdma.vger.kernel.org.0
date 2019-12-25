Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1C12A668
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 07:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLYGdA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 01:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfLYGdA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Dec 2019 01:33:00 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA6E20722;
        Wed, 25 Dec 2019 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577255580;
        bh=BE3A3W1KrDqW7LdhVRh5oKj+vzRX35KotiUVPnUCzqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdEcNmy3kOa+YWvvLkqtGHCAjWqDN3n7wW5zU4r2dqKIa6NHT3PMYbEof1eCLgAb6
         WOWxR5h6HW0sTS3DjIJNFeueaK2EBrAVjlMyCJW3GHymtlrORq6z91CgalJ+KMqRGv
         g7iP+Zo01K0Rc6xN9hCTWg60ABC3z9muyccPIQaQ=
Date:   Wed, 25 Dec 2019 08:32:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rxe panic
Message-ID: <20191225063256.GB212002@unreal>
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 25, 2019 at 12:55:35PM +0800, Frank Huang wrote:
> hi, there is a panic on rdma_rxe module when the restart
> network.service or shutdown the switch.
>
> it looks like a use-after-free error.
>
> everytime it happens, there is the log "rdma_rxe: Unknown layer 3 protocol: 0"

The error print itself is harmless.
>
> is it a known error?
>
> my kernel version is 4.14.97

Your kernel is old enough and doesn't include refcount,
so I can't say for sure that it is the case, but the
following code is not correct and with refcount debug
it will be seen immediately.

1213 int rxe_responder(void *arg)
1214 {
1215         struct rxe_qp *qp = (struct rxe_qp *)arg;
1216         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
1217         enum resp_states state;
1218         struct rxe_pkt_info *pkt = NULL;
1219         int ret = 0;
1220
1221         rxe_add_ref(qp); <------ USE-AFTER-FREE
1222
1223         qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
1224
1225         if (!qp->valid) {
1226                 ret = -EINVAL;
1227                 goto done;
1228         }

Thanks
