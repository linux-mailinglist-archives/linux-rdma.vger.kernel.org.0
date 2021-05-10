Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD537828F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhEJKgI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 06:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232527AbhEJKex (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 06:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92EF3617C9;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=bvAp2WsPdEAnS4cT5tTgRmwfd4Xl/OZGOvJ5sReZudg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBvSFPm9Pow+gDMnwWvp6W/odudwFDmbssdpyklWPKnDCST/sztlAyNLl/T0Ja2TX
         rPz/WjVXP7vfrfS3iqHqSc7yOHcTnU8JF1Dz/J9VJGv7JbA67n/+dg0awu9S996pyQ
         Dx9jeIXDbmh0gACePHkxk4vU6yY+htEdvGU5uMqQ+bUMrX7wUeeI7Nx3rWQ8xeOpLj
         pU7FUI8yfN8nPbyZPFNv0Ek4SzGXQgRnkNtQNE0ApvFPuJRv03FlTWXKOBe52XFJ9M
         OLlvTvB4w7p8J7vXao3Cisn1DmGWDfiJbLSLe00YyYgKUYfd7zgq1M1nb0nUFv/LJl
         PfZ7bacBlwqeg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UYB-GR; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH 47/53] docs: infiniband: tag_matching.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:59 +0200
Message-Id: <723f330f99b58b3ea8188e3cd2346519b8d576e4.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2013 ('–'): EN DASH
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/infiniband/tag_matching.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/infiniband/tag_matching.rst b/Documentation/infiniband/tag_matching.rst
index ef56ea585f92..b89528a31d10 100644
--- a/Documentation/infiniband/tag_matching.rst
+++ b/Documentation/infiniband/tag_matching.rst
@@ -8,15 +8,15 @@ match the following source and destination parameters:
 
 *	Communicator
 *	User tag - wild card may be specified by the receiver
-*	Source rank – wild car may be specified by the receiver
-*	Destination rank – wild
+*	Source rank - wild car may be specified by the receiver
+*	Destination rank - wild
 
 The ordering rules require that when more than one pair of send and receive
 message envelopes may match, the pair that includes the earliest posted-send
 and the earliest posted-receive is the pair that must be used to satisfy the
-matching operation. However, this doesn’t imply that tags are consumed in
+matching operation. However, this doesn't imply that tags are consumed in
 the order they are created, e.g., a later generated tag may be consumed, if
-earlier tags can’t be used to satisfy the matching rules.
+earlier tags can't be used to satisfy the matching rules.
 
 When a message is sent from the sender to the receiver, the communication
 library may attempt to process the operation either after or before the
-- 
2.30.2

