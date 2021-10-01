Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340FA41EEAC
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353433AbhJANiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 09:38:23 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:41606 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231416AbhJANiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 09:38:22 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Oct 2021 09:38:22 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 7A58B802F945
        for <linux-rdma@vger.kernel.org>; Fri,  1 Oct 2021 13:31:25 +0000 (UTC)
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0674D181CC40F;
        Fri,  1 Oct 2021 13:31:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id A9644315D7D;
        Fri,  1 Oct 2021 13:31:22 +0000 (UTC)
Message-ID: <256e577b57eb21555de96846d1ac4cfa3b8ee238.camel@perches.com>
Subject: Re: [PATCH v2 1/1] infiniband: hf1: Use string_upper() instead of
 open coded variant
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri, 01 Oct 2021 06:31:21 -0700
In-Reply-To: <20211001123153.67379-1-andriy.shevchenko@linux.intel.com>
References: <20211001123153.67379-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A9644315D7D
X-Spam-Status: No, score=-1.81
X-Stat-Signature: g9ygsf6tgcr1r6sycycn3e33ide4qgm8
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19xWmYIescM5VhJLkm8KXhZgeIgpmZJRoI=
X-HE-Tag: 1633095082-359233
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2021-10-01 at 15:31 +0300, Andy Shevchenko wrote:
> Use string_upper() from string helper module instead of open coded variant.

Perhaps these string_upper and string_lower utility functions
should return dst not void so these functions could be used in
output calls.

So instead of:

+		string_upper(prefix_name, prefix_name);
 		snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);

this could be consolidated:

		snprintf(name, sizeof(name), "%s-%s", string_upper(prefix_name), kind);

Perhaps:
---
 include/linux/string_helpers.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 68189c4a2eb11..ef92a9471f2a9 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -81,18 +81,26 @@ static inline int string_escape_str_any_np(const char *src, char *dst,
 	return string_escape_str(src, dst, sz, ESCAPE_ANY_NP, only);
 }
 
-static inline void string_upper(char *dst, const char *src)
+static inline char *string_upper(char *dst, const char *src)
 {
+	char *rtn = dst;
+
 	do {
 		*dst++ = toupper(*src);
 	} while (*src++);
+
+	return rtn;
 }
 
-static inline void string_lower(char *dst, const char *src)
+static inline char *string_lower(char *dst, const char *src)
 {
+	char *rtn = dst;
+
 	do {
 		*dst++ = tolower(*src);
 	} while (*src++);
+
+	return rtn;
 }
 
 char *kstrdup_quotable(const char *src, gfp_t gfp);


