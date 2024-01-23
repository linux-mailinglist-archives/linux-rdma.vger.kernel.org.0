Return-Path: <linux-rdma+bounces-707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A11838692
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 06:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA88B219BA
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5390210F;
	Tue, 23 Jan 2024 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e+BB92kQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379DD23BD
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986668; cv=none; b=V3ze6gG1kxtl6XkJyoBsSWci6mz5PhEeNz6ytsXL3jMDZVeLub8/8GBY2wksmPoYF0BIzXL6fhxIcLAX4tTCP+nxdn4twYeejF5FV3xDo2QAt0At5id/kXzPHdlEJ1nUhD92ozRWj/svg1nec86sij+VUgcgjlkCkDvW2WNtYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986668; c=relaxed/simple;
	bh=5cVuwtaVLgoYIVnYKAKnWBKSfZiFw/ZtUhHN9FAKXaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=KKtlxTxd0Ke+eOJ+TShAWbc2CCC+ECmOZgB744V9Cjao22etCCfpVq4UaB+hXDwDFJCYpcVJ693FAue9g8uZf/y4C4gQMLRaU4ULQwFz9DP3u4KcP+dS25iY8SCFdaefDI07/zBs8tGYIB1IGb8wJbpqXhXkBWdcyXyt8pwOHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e+BB92kQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3843921b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 21:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705986666; x=1706591466; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YaZ0YdzS8TUbiDv9DkUyCiRYGLiis7g8Jj1PIYd/dY=;
        b=e+BB92kQ9xynzbtR23esjxlk1BzrqAtH1+eDjkDV2lURlWnQ7ZzHfbHVpGvUJhU5WF
         HUN4CaxTKoFfmu0sqVfFZejT6T8mioJI2mXiLvKt1rMKWd/Ub2lGqiNTOlnI3QkJjW58
         7w0Yr2y3ipacN6/TKTocyCcwqDlb6VxTQ4TYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705986666; x=1706591466;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YaZ0YdzS8TUbiDv9DkUyCiRYGLiis7g8Jj1PIYd/dY=;
        b=OXk0zNcM1ho3D6RhPonNklubXVlZgTRAkVkLhlSouCjr/OriPgtDWGCuGm9vmt0pI+
         cNxaSEFtB5dFa0g3UnKPVH+S7KWEC7NNDbXFSqk69QE8XREwSDslfy/GqDlOlec7jK7U
         nD8LQmS75PcgGNBrH++TqEWcLGeOfeKHL0u28OO926ioP6kL6VHasGeBJ4lB4/FZeagH
         1KYdrIsbchXGMHFGVj6iXlkUEKofbKadoY2Mf+nYufvpIVRgf6a7nd1tPvSO9eheMrLW
         txF8buMvmFYpt+QdSucOSBFi/d6jLkfYEHNYbYSFHwMKjJZQdOYu9z7qFBWo0lf6Iws5
         CJAg==
X-Gm-Message-State: AOJu0YwzMkgJW0b1QNpJ7LHIN2vXUiygCEE0xil5cfccbq0OaaH+jQFT
	NMM2GBun6YpgYEtNWsnUBgSoFsFd6KFMCoO0ZFYwC1nbGnpJyqbd+9qNBOEcRQ==
X-Google-Smtp-Source: AGHT+IEYrPym4wXIN0g/+6QIqy6A/UELL+IwJVzoG+Pv/wXe46qSdJSIUG26sblLPg55qfjrY3mpGg==
X-Received: by 2002:a05:6a20:548a:b0:199:a2a8:da72 with SMTP id i10-20020a056a20548a00b00199a2a8da72mr6691894pzk.10.1705986666503;
        Mon, 22 Jan 2024 21:11:06 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id lp4-20020a056a003d4400b006dce766903dsm672949pfb.90.2024.01.22.21.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 21:11:05 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 3/5] RDMA/bnxt_re: Fix unconditional fence for newer adapters
Date: Mon, 22 Jan 2024 20:54:35 -0800
Message-Id: <1705985677-15551-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1705985677-15551-1-git-send-email-selvin.xavier@broadcom.com>
References: <1705985677-15551-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000460f36060f95f97a"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--000000000000460f36060f95f97a

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Older adapters required an unconditional fence for
non-wire memory operations. Newer adapters doesn't require
this and therefore, disabling the unconditional fence.

Fixes: 1801d87b3598 ("RDMA/bnxt_re: Support new 5760X P7 devices")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e1ea492..fdb4fde 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2566,11 +2566,6 @@ static int bnxt_re_build_inv_wqe(const struct ib_send_wr *wr,
 	wqe->type = BNXT_QPLIB_SWQE_TYPE_LOCAL_INV;
 	wqe->local_inv.inv_l_key = wr->ex.invalidate_rkey;
 
-	/* Need unconditional fence for local invalidate
-	 * opcode to work as expected.
-	 */
-	wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
-
 	if (wr->send_flags & IB_SEND_SIGNALED)
 		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_SIGNAL_COMP;
 	if (wr->send_flags & IB_SEND_SOLICITED)
@@ -2593,12 +2588,6 @@ static int bnxt_re_build_reg_wqe(const struct ib_reg_wr *wr,
 	wqe->frmr.levels = qplib_frpl->hwq.level;
 	wqe->type = BNXT_QPLIB_SWQE_TYPE_REG_MR;
 
-	/* Need unconditional fence for reg_mr
-	 * opcode to function as expected.
-	 */
-
-	wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
-
 	if (wr->wr.send_flags & IB_SEND_SIGNALED)
 		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_SIGNAL_COMP;
 
@@ -2729,6 +2718,18 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 	return rc;
 }
 
+static void bnxt_re_legacy_set_uc_fence(struct bnxt_qplib_swqe *wqe)
+{
+	/* Need unconditional fence for non-wire memory opcode
+	 * to work as expected.
+	 */
+	if (wqe->type == BNXT_QPLIB_SWQE_TYPE_LOCAL_INV ||
+	    wqe->type == BNXT_QPLIB_SWQE_TYPE_FAST_REG_MR ||
+	    wqe->type == BNXT_QPLIB_SWQE_TYPE_REG_MR ||
+	    wqe->type == BNXT_QPLIB_SWQE_TYPE_BIND_MW)
+		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_UC_FENCE;
+}
+
 int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr)
 {
@@ -2808,8 +2809,11 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 			rc = -EINVAL;
 			goto bad;
 		}
-		if (!rc)
+		if (!rc) {
+			if (!bnxt_qplib_is_chip_gen_p5_p7(qp->rdev->chip_ctx))
+				bnxt_re_legacy_set_uc_fence(&wqe);
 			rc = bnxt_qplib_post_send(&qp->qplib_qp, &wqe);
+		}
 bad:
 		if (rc) {
 			ibdev_err(&qp->rdev->ibdev,
-- 
2.5.5


--000000000000460f36060f95f97a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDchu2Ej30ke
Ra1OP6W6VkE8EPAIuQIG8b732NpuBku9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDEyMzA1MTEwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCp3DPObaFDvoZm9Co3228V7iwoeu1Z
57OcdFunV/bH5uEick7B0P2RUMe4JfvGEHnbt37s0vKX78aGyvpDM0MVu4jYHwMa76FKGUKH2EiQ
O/WUwSdGqZV5sbA1wexegnlkj1aKLQ2yvunX7lNcRcTxoBwMf5EvJsQs0UHbtSYTG59HS8/5JI29
b+TZO1beRYWivjznGcqiFpl8U0NSX+hJiOEYhE2Gr77804r+xvchDSn+H0IDrTDiQAKNt1NKhPEv
OPfU+OtvF2rTizly0YFj0+8Q9d80NDtPNwjdC8AEvum84yJYPqY6yWXf7injNnxo7yUUShQEYT9B
C/bE3jTV
--000000000000460f36060f95f97a--

