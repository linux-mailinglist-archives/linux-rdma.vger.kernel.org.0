Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C247959B66
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfF1Mce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 08:32:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfF1Mak (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V7JIWWhPcT+5yqxuCOBchLobwKYQE+u3mOkKIRd8WXM=; b=Tw6xjWLNk1p/qSiCkK9nPabY3/
        5Zkf0h51r6TLCO9A040oEGAhhPZpC7mpKJCc2tcNvcOJzOnp4k+ua3oMUlEKpeOP3jcT0ycPnvmzm
        YngxJ2RXhCl6xZtDRP8avCqXLVuqQ1PUhmcDZ/6nPDtbBF0Kjffuh0mfZihxJuu1NsFD3gmRiRza+
        2lt53ccy9A0ixQGq9ZvbktC1U+QqKR+7mBQiKvldJOPGgdFwtfx+5kyX/trtggicqgRGUP948EhKF
        elSbGwCvtM4J0pc+NXx3ZGV692248dFPsktWbOprVjNzlLJsCxaPMaGai524AYTkNM0LyXNTrX5bi
        XDkW+drw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055u-Qm; Fri, 28 Jun 2019 12:30:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Tj-Rj; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 35/39] docs: infiniband: add it to the driver-api bookset
Date:   Fri, 28 Jun 2019 09:30:28 -0300
Message-Id: <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While this contains some uAPI stuff, it was intended to be
read by a kernel doc. So, let's not move it to a different
dir, but, instead, just add it to the driver-api bookset.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst            | 1 +
 Documentation/infiniband/index.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index ea33cbbccd9d..e69d2fde7735 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -96,6 +96,7 @@ needed).
    block/index
    hid/index
    iio/index
+   infiniband/index
    leds/index
    media/index
    networking/index
diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
index 22eea64de722..9cd7615438b9 100644
--- a/Documentation/infiniband/index.rst
+++ b/Documentation/infiniband/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ==========
 InfiniBand
-- 
2.21.0

