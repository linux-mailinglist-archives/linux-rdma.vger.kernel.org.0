Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2854479A99
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Dec 2021 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhLRLiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Dec 2021 06:38:51 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17260 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbhLRLiv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 Dec 2021 06:38:51 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Dec 2021 06:38:51 EST
ARC-Seal: i=1; a=rsa-sha256; t=1639826617; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Vco2WXhTpp1NubYorLtakbTZxn1Ivlz/cOeWCNaDeG7Gvhm4OS/VnyUFLU4zsOoQa5lF34IRbTMpXzUi01yQL1ru0ZAyxx+3XxtkAQb7paeeGFcne4oxXcXzpgn/U3mmblLtDUdStDS6cRF+nfRxyuTEMMqvzWVbsc0fd8YJgec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1639826617; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=k7qH+Tr0HDmvBzMd8Ppv4ahMM5S5EO7ndCeJo+FfBPg=; 
        b=dfCljeIJe9KR0Wqhkdhd0iF/moRZcYZd7lLfJFA+MavWwgtPuh7q3bAGtr6RwNaI0WmXLF+sRvvkus6TEYaoHtDDFVb8hE8FyNkGihZbp1npQnLevynq3nMKg9fuoNSB52ta9adXV55Q8xGhXNu4IMxAM7cV5OLZbSg2KnSRLmc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1639826617;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=k7qH+Tr0HDmvBzMd8Ppv4ahMM5S5EO7ndCeJo+FfBPg=;
        b=Mkpm46qCgf7r+0u2/Fx7haPBefpK8kveJexlqFim/Eb4icH53nZXfxu8psrylKGL
        fsXO8LrTGC9Mu8TA3drCjOUSP3XQyxCmUEoZBM3lyimKfkyApU+DxayCvCHpJGW1aof
        +m9D6I5J7xnfTqc05Ep2dTGs8YPgEaQWRwCZtitU=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1639826614316722.9621173199579; Sat, 18 Dec 2021 19:23:34 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20211218112320.3558770-1-cgxu519@mykernel.net>
Subject: [PATCH] RDMA/rxe: fix a typo in opcode name
Date:   Sat, 18 Dec 2021 19:23:20 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a redundant ']' in the name of opcode IB_OPCODE_RC_SEND_MIDDLE,
so just fix it.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw=
/rxe/rxe_opcode.c
index 3ef5a10a6efd..47ebaac8f475 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -117,7 +117,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] =3D {
 =09=09}
 =09},
 =09[IB_OPCODE_RC_SEND_MIDDLE]=09=09=3D {
-=09=09.name=09=3D "IB_OPCODE_RC_SEND_MIDDLE]",
+=09=09.name=09=3D "IB_OPCODE_RC_SEND_MIDDLE",
 =09=09.mask=09=3D RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_SEND_MASK
 =09=09=09=09| RXE_MIDDLE_MASK,
 =09=09.length =3D RXE_BTH_BYTES,
--=20
2.27.0


