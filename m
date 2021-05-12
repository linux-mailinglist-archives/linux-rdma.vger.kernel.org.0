Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1AD37BD46
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhELMxn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhELMxF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 08:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C858961461;
        Wed, 12 May 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823907;
        bh=5Y/5Sq1wRSGXoldO0sQDb3+KvKQ0vjGyLgU9p/3cJcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfM97qNJ3LzXj70sWi7fbjJTJHTrkyFFQvRmdST/NWO8zL4EZwfpCHjYkc5bYp5Ik
         z+Q6Yx/g4ex3MNRyNsnnTf+QKfnDbFsgIpaYj3lYqmp1lxTj6CHcwickbCwo/pMUci
         xd0dh7/PaLIfJxw9S4TcvcpeLWwSD2Lh0FzPiIcLkRqYhmp8XPgcgGHBxDb67GdGE6
         PEy4nzVXNqfkUl3xEO+jjaT2Uj4LKH8xMwV4Oqp46RzUcPFg79IuscMKrvniqMbnRk
         SxE2HxVCqk7cczDqLzn1wHHCP8Okz3+CJij4BH2xsMZETi6MgvRtlY3qI7n9Y3mXMt
         IgbkyHC42TAvw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoL3-0018ne-O1; Wed, 12 May 2021 14:51:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH v2 35/40] docs: infiniband: tag_matching.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:39 +0200
Message-Id: <e24e9f703d46b4faadff0fad462d3139efc71b2a.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/infiniband/tag_matching.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/infiniband/tag_matching.rst b/Documentation/infiniband/tag_matching.rst
index ef56ea585f92..f7583b48963f 100644
--- a/Documentation/infiniband/tag_matching.rst
+++ b/Documentation/infiniband/tag_matching.rst
@@ -14,9 +14,9 @@ match the following source and destination parameters:
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

