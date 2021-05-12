Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD6137B481
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 05:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELD3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 23:29:09 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:47089 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELD3J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 23:29:09 -0400
Received: by mail-pg1-f178.google.com with SMTP id m124so17167910pgm.13
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 20:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpfFDOKdUbD020JfVQyuA+Evu+NBA9JdyPd4651AemA=;
        b=bccem2BgcaVMkmiJaVHbQv61olmIJXZSr/fiBLnLg0hBcd8/AAB+Oj9zXjJ4szfLwd
         iXxi9oXcrV+iBRkeWNp7EKdgOzkbK9HagLuSIozuTNz5GACPqzf1xhE297YH0q4rqtj9
         zKrcqxdhfSlxg/6mgA0mN8UNo50vi+qBczE6Nw834Vb8LBoDKT+8u+2N+h/qK8ZPWsa4
         pnTjNqMfLhv83vx418YDFAV+n4Gxg0QcgZYZAjn0LzKT6SAikKkiRlkjws1H5oYto/Rx
         kXPm3sF2YX98PqKs8IAUAvBFVqj34ewal+ZAM2HRTmb1CCQ+pIUGIYY1XQ8+nZhvoIaS
         44vw==
X-Gm-Message-State: AOAM531AG2JFr+2KZp8lPE23N/MK8vdihbFB/4nNYVadxvGur/+ptdGN
        2WwCeCvRhKQtwZFRTUgmC7s=
X-Google-Smtp-Source: ABdhPJw1FpFjUBzhLdiVoYSRbb3FiXaD5zBPNUjYWD86RH/rH9Tzn3CJh8IDF90WeDgqNS3uh4CO8g==
X-Received: by 2002:a05:6a00:b8c:b029:28e:eb6c:ea52 with SMTP id g12-20020a056a000b8cb029028eeb6cea52mr34460465pfj.21.1620790080579;
        Tue, 11 May 2021 20:28:00 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:76b9:3c77:17e3:3073])
        by smtp.gmail.com with ESMTPSA id q194sm15008703pfc.62.2021.05.11.20.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:28:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Don Hiatt <don.hiatt@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH 1/5] RDMA/ib_hdrs.h: Remove a superfluous cast
Date:   Tue, 11 May 2021 20:27:48 -0700
Message-Id: <20210512032752.16611-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512032752.16611-1-bvanassche@acm.org>
References: <20210512032752.16611-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

be16_to_cpu() returns a u16 value. Remove the superfluous u16 cast. That
cast was introduced by commit 7dafbab3753f ("IB/hfi1: Add functions to
parse BTH/IB headers").

Cc: Don Hiatt <don.hiatt@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/rdma/ib_hdrs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
index 57c1ac881d08..82483120539f 100644
--- a/include/rdma/ib_hdrs.h
+++ b/include/rdma/ib_hdrs.h
@@ -208,7 +208,7 @@ static inline u8 ib_get_lver(struct ib_header *hdr)
 
 static inline u16 ib_get_len(struct ib_header *hdr)
 {
-	return (u16)(be16_to_cpu(hdr->lrh[2]));
+	return be16_to_cpu(hdr->lrh[2]);
 }
 
 static inline u32 ib_get_qkey(struct ib_other_headers *ohdr)
