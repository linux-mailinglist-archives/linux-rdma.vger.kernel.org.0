Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA92B57AB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 04:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKQDFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 22:05:00 -0500
Received: from gentwo.org ([3.19.106.255]:36614 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgKQDE7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 22:04:59 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 22:04:59 EST
Received: by gentwo.org (Postfix, from userid 1002)
        id DFD7A3EF63; Tue, 17 Nov 2020 02:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id DDE6D3E8D6
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 02:57:57 +0000 (UTC)
Date:   Tue, 17 Nov 2020 02:57:57 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     linux-rdma@vger.kernel.org
Subject: Is there a working cache for path record and lids etc for
 librdmacm?
Message-ID: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We have a large number of apps running on the same host that are all
sending to the same set of hosts. Lots of requests for address resolution
are going to the SM and for a large set of hosts this can become too much
for the SM.

Is there something that can locally cache the results of the SM queries to
avoid additional requests?

We have tried IBACM but the address resolution does not work on it. It is
unable to complete a request for any address resolution and leaves kernel
threads that never terminate instead.


