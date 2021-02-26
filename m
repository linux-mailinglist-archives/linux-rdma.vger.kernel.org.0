Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18E3264E5
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Feb 2021 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZPtA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 10:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhBZPtA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Feb 2021 10:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614354452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=r5QYCQaVbVi9Ys3ZbI41C5UjH3p581MKTM/x4dJi5jU=;
        b=i5QuOEvkCC14dzNxlcye1MaP1YUn9Gu82iYUq/AQFbiualgUYaBHzVLHTHImUMrCq5qhvb
        iXYEhdqRZfjG21lP2x73t6BS43OD6IkVipo7WQBIfZgneCb7Psb23Xt9bE40PiRa9F8HfF
        x8aIKll5oyD7dr9o5lUJp2/FDHi7iic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-feWzZiVHMJKTo3uQalfncw-1; Fri, 26 Feb 2021 10:47:30 -0500
X-MC-Unique: feWzZiVHMJKTo3uQalfncw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D2D3C295
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 15:47:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 273955C23D
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 15:47:29 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2142718095CA
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 15:47:29 +0000 (UTC)
Date:   Fri, 26 Feb 2021 10:47:28 -0500 (EST)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-rdma@vger.kernel.org
Message-ID: <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
In-Reply-To: <1688338252.14107275.1614354083739.JavaMail.zimbra@redhat.com>
Subject: modprobe rdma_rxe failed when ipv6 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.13]
Thread-Topic: modprobe rdma_rxe failed when ipv6 disabled
Thread-Index: sewH6LO4FWHr05gB+4H7dftwbji45Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

I found this failure after ipv6 disabled, is that expected?

# modprobe rdma_rxe
modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted

# dmesg
[  596.783484] rdma_rxe: failed to create udp socket. err = -97
[  596.789144] rdma_rxe: Failed to create IPv6 UDP tunnel

# uname -r
5.11.0



Best Regards,
  Yi Zhang


