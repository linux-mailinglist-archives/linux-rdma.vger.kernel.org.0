Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3C132F6B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 20:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgAGT3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 14:29:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40338 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGT3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 14:29:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so210204pjb.5;
        Tue, 07 Jan 2020 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vHcS5MGixSiDikhb0k92gL0arFETtVoaijzCLdHtLs4=;
        b=Doa0xXd4L03LriDOdzUb4PU2OvOqF2EQ8JOzdGLm73k7Vxe/dz15NwT7qpKFg8RrNJ
         65cNAAU4n7s14QuA25hrNAMpkYen3wc6txbuBvmkpRgQvOY3zSfU9Kt6DtpqFVmwFFty
         IR/ORtSpbVlygr3LEUQwC9kKqZWpt/myftShQUzkBPuN0sZ0IgtTI34IVdXtQJE8VIHw
         MDjsz/M4AqyXXrBtJOFfLD2fPWfSjUgt6BxH5ZDSFwelFWyIA7/W4dRdHhCtWL+oLDOd
         1lhLfZ5sQ7/mfya9t5ChQCM/176AKI/2Jl6+r+bZuIZ9TSMv8syU0lh7RCMnq9lZjp/D
         Rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vHcS5MGixSiDikhb0k92gL0arFETtVoaijzCLdHtLs4=;
        b=jTXYhoxUs3KCC1Tn8dqKrgGHBq9pTDaN0KeWnFt3Rch9IRjmGkd5N11TZNq861VbE0
         yMK/4GvoFTkYrVyQvWHgd9UriKCFHjnamQuiYwMsakCFp3jRq9Mxe1jdWbjXh+I4BuMH
         b8iTXmKoh1vYprCfHSIInuT+ffteermz40Y7meX89CoJrrnYgsIvFPLEzzgcedJtg93D
         I89r3jPnd6PcLTRQ6v5LTs2/JbF1twbV0lRprBvXz/XNXRdHnA2LACEZMZ1Pg9Zdvea5
         wVNuXxe/5RPDfFthNpmw3JviFJo4axTrUDxQhnTQ/z6UCxPO5nNbk1neI6bv2tpN0LpZ
         jm6A==
X-Gm-Message-State: APjAAAUbJrZlkwjiIQw0STWAKZMw9GSybWWpaFicYPJbKNR+YcfeNrGq
        3DUZsOwmNtFzyNbxblhqi5Y=
X-Google-Smtp-Source: APXvYqyWhmCx9SqRgxjB8qdN1U0G0J1bBoWoaWFrOZ9tfpnMbEDodA/3o3t2QYZgXg19a7MsJuhHyA==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr1291908ple.176.1578425362592;
        Tue, 07 Jan 2020 11:29:22 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:fd53:8500:6ea8:4ef2:c9be])
        by smtp.gmail.com with ESMTPSA id w7sm333554pjb.31.2020.01.07.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:29:22 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list checking
Date:   Wed,  8 Jan 2020 00:59:12 +0530
Message-Id: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

list_for_each_entry_rcu has built-in RCU and lock checking.
Pass cond argument to list_for_each_entry_rcu.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 089e201d7550..e6abdbcb4ffb 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
 				       opa_get_lid(packet->dlid, 9B));
 		if (!mcast)
 			goto drop;
-		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
+		list_for_each_entry_rcu(p, &mcast->qp_list, list,
+					lock_is_held(&(ibp->rvp.lock).dep_map)) {
 			packet->qp = p->qp;
 			if (hfi1_do_pkey_check(packet))
 				goto drop;
-- 
2.17.1

