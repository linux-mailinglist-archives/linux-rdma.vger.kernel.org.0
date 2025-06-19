Return-Path: <linux-rdma+bounces-11444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D3AE01D4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F8F7A5AB7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFCC21E0BA;
	Thu, 19 Jun 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Q41vX2XG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAA1E3DE8;
	Thu, 19 Jun 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325910; cv=none; b=hlmlA/IGEu99EWaqz/q5HDin4+rIo6lvDH9LSvB9sI7OXWL141Q4F/YSISLA80EeN+nZhLhWWmW7den1khgtft2K2zU1A71T3wSzvoMxXfrRUZsge6JWEFP5CltB4u6D+kfm1f44+56+ziBsznqsdRMLCRoe3Yv3ROJ2+2cgaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325910; c=relaxed/simple;
	bh=zrMqYXcpt3+8hKWKWL9H+r6ZpkeEiXxfMbk+2N1urQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5tT289lxua3NgIAlDBS60iQSoXC5AgBg0zhFXflI/fXpKjVEumfGg751e2hpgUu99TspMHB9bNVnWdZJKwAw+/oMxY/3HXhURzHzRaUrRb+ukRJVcpflNEL1lLSS2qJ1BCeNLDy9zwK7rb80jySOHJDtcMWbEujokrabOiGunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Q41vX2XG; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750325856;
	bh=oAEDq5dDKcnnS2/NFb3lJLZSim6PZMNBCCc44x/tKTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Q41vX2XG1nUzOByycrqcBvAMn/vPcQAvh4uFnptMR1XtJKRcvdYKHRL0Zu7GvnTGi
	 t1Dk8EAPmsZNeortwavqiRZpopaeF9TSRFu/FjmjlLP5Gy+nqL2ARMYed4IlY7pz9i
	 u/vH6h2FGU68JWeqp5PGoXbUDCINfHMkRRreAXXs=
X-QQ-mid: zesmtpip3t1750325846ta1212646
X-QQ-Originating-IP: cPfN9IJ3VtsMCBPFjOYSeIoL7AU/sGrgpJdMxuk/5Fg=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 17:37:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6388095992895865980
EX-QQ-RecipientCnt: 12
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: tangchengchang@huawei.com,
	huangjunxian6@hisilicon.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Winston Wen <wentao@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 6.12/6.15] RDMA/hns: initialize db in update_srq_db()
Date: Thu, 19 Jun 2025 17:37:19 +0800
Message-ID: <3FDAD147897E51E6+20250619093719.90186-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAMW4dxoxFythkLOmcE2IVooIkFLNl2vqZWLXB/0YFDTYFWT2T4TkzGd
	loMUW0PDHaWTvSuWPyLssjMULuQl+3Oufspl0q3n7du8kFru0FPrA83A/D5cMuCBuTz6ex5
	OnlBF3lLtJ8B/B/gnlESEobiq+J/cd2durlac0OPt5AxIZW1+QSGxDFmzetEgogQ3PgldI4
	jubRl8FOnNVt95k8MahauTmNjJ98grAp+UCvh0nvjGVrwdw+qx4ZI3hJAm4rcplRpo5cmPd
	zsF7HCFWgnWadMAjstXej7qt0CelCDtIbyE7ROo0QsyjYokcgoq/Ezq6SQujGaCdMPWF7gA
	T1409n+UhIEinTp8zIVbSJ5mf0PJmMEWbDRsQte+TkemLLhefFzydwEApwV0KI3Ba6dgd64
	jyuRg5qyO43Bn/uP+YmdFqjy4lFKomwPdqGM5xomEZy1nnUsq8qV2Uxy9K6m+Nl8oM5uSfq
	P0YSTpO7QUxlun/6JTqlz4TrLNF9VCCdyN9ZevjHqrpSBssJCR6J2c9mUYDYb8CMdxU4ytS
	6OG4I4/KXzyD94n21cd0TqkPxOzdgiQVenXN3RWJ38qEvrjeocP2IMewYfyY5Gw9zRHo+Bk
	Q5GwNozIWKxjQgZrqmoClUrJZfEm8Wnmd1ruhdcBL/jmrPJRfXAeibbZHKCdm8yIN+0UI6G
	JFaiCPLMrlrHGkg6iAgAvfzfZ32FFYYmV6UOtANPJOT02BoQsEBGSVVgBS00eQRjcO0Q1pd
	sgye5Lh1YhLjKYUVxX2Hdek7Unag5cky3zKFIPIv4BgjNByvXlXz/7JuydrluJaBh3IEJwQ
	28noT7PAAS3+4U6zT+0uPKeDxYPmVJTVuW5jFGt1HCiFf1o+5fNe2xKWHFVshpaQMrrxLtS
	Hdx4BrResuMnubSmB6djdGyxMV7Uz9313agc52KiV75a+5HLiONN7NmlaGGyqD5Ui0fNyV0
	Jp7R1qa59YMCkz5iBNN7OB4VYhQ9F+xnb8yHxgoqlEjvqX7EYmIABHvnlfA6wtWw4DuWHUU
	QTlz4pDo9hIa656+5vHg6vGCsAyRAIqRmnYhjwcAEpmyxMXhTNwOBgBMVgTIo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Chen Linxuan <chenlinxuan@uniontech.com>

[ Upstream commit ffe1cee21f8b533ae27c3a31bfa56b8c1b27fa6e ]

On x86_64 with gcc version 13.3.0, I compile
drivers/infiniband/hw/hns/hns_roce_hw_v2.c with:

  make defconfig
  ./scripts/kconfig/merge_config.sh .config <(
    echo CONFIG_COMPILE_TEST=y
    echo CONFIG_HNS3=m
    echo CONFIG_INFINIBAND=m
    echo CONFIG_INFINIBAND_HNS_HIP08=m
  )
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
    drivers/infiniband/hw/hns/hns_roce_hw_v2.o

Then I get a compile error:

    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC [M]  drivers/infiniband/hw/hns/hns_roce_hw_v2.o
  In file included from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:47:
  drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'update_srq_db':
  drivers/infiniband/hw/hns/hns_roce_common.h:74:17: error: 'db' is used uninitialized [-Werror=uninitialized]
     74 |                 *((__le32 *)_ptr + (field_h) / 32) &=                          \
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_common.h:90:17: note: in expansion of macro '_hr_reg_clear'
     90 |                 _hr_reg_clear(ptr, field_type, field_h, field_l);              \
        |                 ^~~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_common.h:95:39: note: in expansion of macro '_hr_reg_write'
     95 | #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
        |                                       ^~~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_hw_v2.c:948:9: note: in expansion of macro 'hr_reg_write'
    948 |         hr_reg_write(&db, DB_TAG, srq->srqn);
        |         ^~~~~~~~~~~~
  drivers/infiniband/hw/hns/hns_roce_hw_v2.c:946:31: note: 'db' declared here
    946 |         struct hns_roce_v2_db db;
        |                               ^~
  cc1: all warnings being treated as errors

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Co-developed-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Link: https://patch.msgid.link/FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 160e8927d364..afd2ea6da3ee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -943,7 +943,7 @@ static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
 static void update_srq_db(struct hns_roce_srq *srq)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
-	struct hns_roce_v2_db db;
+	struct hns_roce_v2_db db = {};
 
 	hr_reg_write(&db, DB_TAG, srq->srqn);
 	hr_reg_write(&db, DB_CMD, HNS_ROCE_V2_SRQ_DB);
-- 
2.50.0


