Return-Path: <linux-rdma+bounces-19077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ea0C6zN1GmtxgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 11:26:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA53ABE6A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 11:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2D73030B31
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7121DFDE;
	Tue,  7 Apr 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCeZvqSO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131D31353B
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553653; cv=pass; b=ldThbymqcNlvNVOL3KElyFwAPVCUC3jK35+8F2ZGx4lrqVtBwELuDfT6NS5JE2Ws/ecGOedteb8exhkvlaOfdiium1A2wIaXbInF8AhGRxl7N2DedMne9xcwz+7P+NUIiSRdhuhKxibNjRAlvz5KVpHmFax4yOmf5BMWzbU4VFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553653; c=relaxed/simple;
	bh=Z6zoDd1TdRAWV/RFl1T6g1/3lSdNgV2wjs38eEh51mU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oHAnyZ+1tTiN1mcz/MS2asvGb/s2+XzX8Mhm7ZC9nqfv0K7sQsfsnPqo2frklF5NKNV8OkSz+SyTw+ul7fD99laRzk4NNYF8dsZY/QKNb+rC2YVMXdytbFjd5OYyhEQKNj6wBgFxUlzqtwr+5ugwLGNNpXY92h4SDV9hyyNAIcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCeZvqSO; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so5760232a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2026 02:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775553650; cv=none;
        d=google.com; s=arc-20240605;
        b=E2gZ2F/Qx28ngVbaeGoN0oXM/wYwHyL0v80DAlDdfh8/3J09VbN1YukzHLKxqLYc+q
         LVDG0cZRFaE1maljxX2EEzGZXQNqZCBmaA+hBdcw5kAr5M7I10o6O3YFCvb4CFVgmJqD
         pGwGuJUH9SjyXqjTJBztrKF2XlUboKUBC5Z9BulwBe+DcIVZzRnSG6n5rK686sXJALfq
         xyDmR5FBwx07FjGyJtdGbNrj/OMIBPiX0SoZOp/rmt4IFJ74rsDd0wfy1VMXD/SU2Pqu
         pCH0GA1AGbCk3tuVP6ke2/EHjB4VKywoFfVQPVo1ONeSd6GfRUCAH9QZJ/vZJQrL7+rC
         WKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Gsz6VDxb1QXOP0+Jlsbv2rsNiiK+1BZLFBvCwZymreE=;
        fh=0shDdce787Qu4RU1yHPUkMzT3v4cbGbWX0LJ0MsdiG8=;
        b=T9/gymcvJpVTAgqCkJxz4D/Gazan0alZ24+b1p8APK51s5VLvwRYQHStZzzz6CI2Ps
         zSayPBdUKHrBsQyYQMlHqVD/6hwHzxrRvkvbuUoJHNCgkusHw5i8YwfTs7+At1COTA89
         YEOt/vxfiKOJp5k5sDiZzSuyh/Ii1D4eJZICW3AvNWXoctPC5qJ2KouBi2pk80Ojopuu
         +U2zyDLTn/eWnQG5Kg/NfiNhyA1UF1JI2Z7FqZpww1euIFyPdbA9roYdsCxeEmNmLKx9
         XFNbmQwghSJXMt4Yp7UL5HaqBhzyM7vpcZdQLpsLg+UWAQFrJ/LVGbvR3La4fb/l98B1
         S4wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775553650; x=1776158450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gsz6VDxb1QXOP0+Jlsbv2rsNiiK+1BZLFBvCwZymreE=;
        b=XCeZvqSOyc5RIEQHXwPIS//ViQdl9K+PH9pDeHofQotYVL9j54lTM8vLokJJxQT1HI
         fio6IbgUF++94YozUnllnlEwZa6ah8DPmCs5TeVwq9lBBgC3NxCitWg+8UwxczsvCSUU
         GDPA7inycp4tJ6zn3fO32Kckp4I18jFVmUm5r4IBUbXXvPUl6kNTRWDDcoK+Ne2nbYx8
         EgKdTaPhAQ659se4K04Xcq7oCPHF1nTaD4GHFdj6R1+BxRTX1DlNQOl0q5+ijPDd17c1
         Numr7Vw9AM8S3xIh3hcFtDStioDVbXZjxET4iiSQa1KUCRQ5K9G5n3G8wkmgovIO4ie3
         LYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553650; x=1776158450;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsz6VDxb1QXOP0+Jlsbv2rsNiiK+1BZLFBvCwZymreE=;
        b=YjtdrrPiwXezN0lqeY3D5qFqy6ORnHS1tVgJCr9WwCkio6YluyHF0TTULDcawrPPy5
         zN1BOBiB7NDEraKJkMFVyIX3KHhFgKrAvwriqa2RGkPC2gCA5P0lg2POcOhi6Vvi/QRe
         3qxEJ2by8z5LwS0B4t4c1Mv9+hy/L6oSs20aGCMiq+usxsJp27N3DPWc6s9P8zERnLb2
         rFZBDuJc6qRjCnNSo0ck8GfYR9BPFCtLIAikSnT4kQxoCqwE/5USysy35UZSEz60nklu
         48dqEW2vld7TpYKmnRJkjdfTytY+txgQyaf/24Qabp70DZ+2hLkbfocFUvTIp62AvBIb
         A4nA==
X-Gm-Message-State: AOJu0YzFe5b7Kfigfe6zOzZRBu70xaqRHysJ/H1I/9K6Hl5S14AnOh/8
	Pp56e8l/lPsSqwsF0CxxA77Rqf2Hp9fyizWRwy2mhvBySA9NA3V38VsYAIB/fQWHLVde4xrUCvi
	wKbR4P5/ayIs802OhfluWAU2jvLziNV0=
X-Gm-Gg: AeBDieuDFPMuI3Bg34yrsTw/NIJcKSS3hcdHgdHuaIPEQTSo65GahaVfqbBQREnG6Rv
	YFI1Y/qSeT8WhcvX5NS/jhHClnTdgen7k3UVcFxCUxqrI/f3/kwfU83uxvtb1FFMCDwxSuW4ciQ
	amzW8OZQIpSA4+HJfPrJ7kPmYxJpjsozyD4oyrywD4nKh8wQWd2E45S9E6nEzb31igZkvLDKVTC
	+GwmBrFNzJGs0womcPuud4e4QOB+EMj0AfEGFBTG42qsVcY6fBNhUjfUF+ojKsNa3gPC4KLIvfN
	XWIsxBi3Bku1vW3x+a0zLbcPCHMX/61N01yZ1XJbbQ7P4Gxloae8Y5lp4NoTUbb/qvITXahPSQ=
	=
X-Received: by 2002:aa7:c48c:0:b0:66b:d0c4:ee95 with SMTP id
 4fb4d7f45d1cf-66e079c6d16mr5745229a12.0.1775553650297; Tue, 07 Apr 2026
 02:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Tue, 7 Apr 2026 12:20:22 +0300
X-Gm-Features: AQROBzBZIjM7dG_3BSGmBww-JXZU6eSsI8uj9TGehcSl5jqbqd8CpeL3KKgMlR8
Message-ID: <CALynFi7NAbhDCt1tdaDbf6TnLvAqbaHa6-Wqf6OkzREbA_PAfg@mail.gmail.com>
Subject: [PATCH] RDMA/ionic: bound node_desc sysfs read with %.64s
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19077-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77AA53ABE6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

node_desc[64] in struct ib_device is not guaranteed to be NUL-
terminated. The core IB sysfs handler uses "%.64s" for exactly this
reason (drivers/infiniband/core/sysfs.c:1307), since node_desc_store()
performs a raw memcpy of up to IB_DEVICE_NODE_DESC_MAX bytes with no
NUL termination:

  memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));

If exactly 64 bytes are written via the node_desc sysfs file, the
array contains no NUL byte. The ionic hca_type_show() handler uses
unbounded "%s" and will read past the end of node_desc into adjacent
fields of struct ib_device until it encounters a NUL.

Match the core handler and bound the format specifier.

Verified against torvalds/linux.git master at bfe62a45.

Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c
b/drivers/infiniband/hw/ionic/ionic_ibdev.c
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -185,7 +185,7 @@ static ssize_t hca_type_show(struct device *device,
        struct ionic_ibdev *dev =
                rdma_device_to_drv_device(device, struct ionic_ibdev, ibdev);

-       return sysfs_emit(buf, "%s\n", dev->ibdev.node_desc);
+       return sysfs_emit(buf, "%.64s\n", dev->ibdev.node_desc);
 }
 static DEVICE_ATTR_RO(hca_type);

--
2.43.0

