Return-Path: <linux-rdma+bounces-21201-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH5zBTICE2od6AYAu9opvQ
	(envelope-from <linux-rdma+bounces-21201-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:50:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB55C29D5
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22830300B470
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33165397E89;
	Sun, 24 May 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdynaAM8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3973914FA
	for <linux-rdma@vger.kernel.org>; Sun, 24 May 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630631; cv=pass; b=A8DfVoY/T/w5mmVq7xf4WNb3Y7tTZ420hJ1FWuv51ASg/XIy3u/pE/NWnHuh3FnMxKi/YXmAKNzHXPhwZqvAm/LYFtdREreTc0qiu0TBJNJckvXSqgn4R1vvYcKI3qvpNMylC5liSNFzNLRLLp8f5ZU5TZfHXgGf7zZ906q5Wf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630631; c=relaxed/simple;
	bh=uii0LdVQpDQEMaF/oP+P85G53PJx+YFYnVwn8J2du0c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bW/pZBAwms+8SvL7Vvu7IqvRAuNTDCIfVi61OP4CjDjcDYxj5YW8ZHXKo5PGYke2FecfrLKzHjL+ntjvBlorKbtxLH/36JvKnrjf+uD/CV99UdGAWjRlEjnSyJTIAE+3DP8SBrINn06/Xx3CQG+hIbmiSad6cYx1R9ApuPV4JE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdynaAM8; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90fe17c157aso957487285a.0
        for <linux-rdma@vger.kernel.org>; Sun, 24 May 2026 06:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779630629; cv=none;
        d=google.com; s=arc-20240605;
        b=fYpWJ16YB/fStp6T77jc2diYSQmJ4m8KXhcq6tTq0h/afVbo8Db8kQfrERirYAeQVA
         zpo2677ITWhWjRZ/A6TGsuf/5re6ghX7oe61Fg47ofsFZUOwQUjuDZbHLFcZ+3CVw5/2
         5IruEuNFza97VeNS0+myLpDquagk8SCTb0QyEI3YrNMj2MuHlRkyw6YURHuWSsimLsil
         BXzdUez3DaiaKssizurV0P1GPFH8t7D2OkUFSgobCSElqoHYiD3l5gCF5dNsJzSwt0cN
         FwrDCLkwrgGg+niSqr7PyU7aKo3Qh0AuHieLu3FWD/W0MEYkSw/U5a2ta5b55CloIuCT
         1h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+JeT5hz1hCbicULiV2h2N0udecL+UajpwWWhxL4W8Yw=;
        fh=Qr9ZWqst8N9e1Ej0VxFNZNS9HRiuud5KRUk3X3njxfg=;
        b=G7/qBX4tyiiVUBgxzgX61EpWWnMKYL6TBZwFciwayR2lBq3p5Xn0J7D1L9rH/fayPo
         bPB7P/9qIndIcTqQ9BIXPF7WD78rjDsymfo6tj4XHxyuAShnWmpLRYadbIz3J4eLl5p5
         Zwut/BcyWhrf5muzSVTTUxt7wWabvDQ7Xr+CSWvnYMeXn+bG1SERJprU6VOXxEUU2eNa
         ZUKydG6hUCxnecVTxXWctkP5jijpDhyg088r/tTIRA5ol5OT6XflCKJROdurPL5RRRzz
         n07HGOXMsdySuK/18L5VX4CWmXTM0iXPTVo2+S04NsNQwYPsKxvSxs7nDpLBeVI0Fv2k
         Qu7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779630629; x=1780235429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+JeT5hz1hCbicULiV2h2N0udecL+UajpwWWhxL4W8Yw=;
        b=TdynaAM8Itjfo2YV3m8FGy6CWyWTPSGdcYmy7BI6ykXLj9YHdSkED2+ZcvoA9EPvl+
         dgt7yTB/FuHiRP/UjXdi7g2mQ4kjzIa1i4FUy+gkVJGFlo51cR93ueINWBZMmsOwsG9F
         zxsR80MnNwL4NPnyDTBzXj3JvPi1HxRJ49VyhdHfc9LO3nHxduQni9RGRkwcwP4JrBTt
         aPesWbf9tx7KQHzSiuvv3Spq1fWjcz07dv5a8SK7eF+8Mia1ucbFaSAG8hZE6ICpwgSR
         zk/QFS10yhRQddyrsjbtHLYkmpTsZGUOx6CAIvWPmOUTd/CKem5BrFo9/e4IYauVtHKd
         clEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630629; x=1780235429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JeT5hz1hCbicULiV2h2N0udecL+UajpwWWhxL4W8Yw=;
        b=S9I2GOs7OG9HnKdqIUk1PqS8dH61j9WcBzd9kM14SrkyrdwArqRe8XEUQDdU2KJ759
         I4gbqsVDbLUdF+qPU68ifskO8uYlJ98CJY0QDymbrfUk8koKG048053lcuaDM4FP8But
         HGkE9Sn/1jnhHmZT7OY/eiZlRj6pSh4//K8+sgXAiry89HjsNapTDysGAl+hei6IKFqW
         oVIvq+rgiOQr3MDD5W/e0+St8Jp6jVb0OGiAc0Bbotqq7GOkBmAkoaxLWMeN7HCEd+5v
         B2zGWk5XVgREqE0In6AlfXp3sdt2CAwk9BIHvx8q+TrAXEeEikGGXhIj2qeSQ3z9SsG/
         qo9w==
X-Gm-Message-State: AOJu0YylELRRahfXV5xaZMp7B4tqP3AGJTMNyC3xsCgEdfdtQBwwUQKy
	KGPHdmsRmYrl6AUUuWd6K0rC1olkF3MM9+99Av/U5HdC530Te0jZFPerGelQyw6TZ7Dw/hbSG+n
	Ms86YTatdDvvyU3aCMXqpmqNm1JZvc2oqDoKdKkMI9A==
X-Gm-Gg: Acq92OE4auoV+4CGw0UvFcb7h2qWuXbNTRdi1poxSoTGgFRVp+zdYwTBTIGkXu8BHev
	JbndckpI0cVwmPZ44XCX5sLa2AjbZbvz21eSEHZQjwa26Z6qBTr1H3JdaZVJx6Y4eF0jn1v+ZM1
	WcZBadl3WkM8AVWzfLlyQxaTFIEIY4KzCGsn6e23G2HZRCEfBOw5yjFCFSUkOgFitqjUBN2FtwZ
	PenVTzTJ8JmAKpK4udZ3ZxzDQptadt2PAEF8Hsft5oQc8M0LIk75WyJzMV/a6Pi5OkzGVWKsVzb
	uOnxUmpFnhLsEN/fh6haBmMhtVR7sp7WKx3s2j3Me0YX+5KaUCOhQa2I1x6uQsqTNT2o2EOB0Gb
	S3n2h+HDXwyZ3MtDU6vYSgvImj9/CM9gCbfzEaZ/1q6wMMwLuFcqnmLgvNC4jgqhBEjglfBUM59
	k1MwCu
X-Received: by 2002:a05:620a:d93:b0:8f4:3bb0:ca7 with SMTP id
 af79cd13be357-914b49ba29fmr1641669185a.37.1779630629060; Sun, 24 May 2026
 06:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: _Vx Ano13 <ano13vx@gmail.com>
Date: Sun, 24 May 2026 20:50:18 +0700
X-Gm-Features: AVHnY4KQm6wBTfgxHVOLHyRuiW8J5Rm3Ed3Sx9Wv9OQDgRCfmexg2a3JkKd7KLM
Message-ID: <CAFdAxs5xz_-jE7+Gg5P=6L5UvoVJCZnF7QHmiCE5CK+1zn+vHA@mail.gmail.com>
Subject: [PATCH] ksmbd: add missing software bounds checks in RDMA transport layer
To: linux-rdma@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, stfrench@microsoft.com
Content-Type: multipart/mixed; boundary="0000000000007a35120652908b85"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21201-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ano13vx@gmail.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6CAB55C29D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007a35120652908b85
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,
This patch fixes a missing software bounds check in the ksmbd RDMA
transport layer. I noticed that a length parameter was not being
properly validated before use, which could lead to potential issues.
Please review this fix. Any feedback is appreciated.
Thanks,
Nguyen Van Tuann

--0000000000007a35120652908b85
Content-Type: application/octet-stream; 
	name="0001-ksmbd-add-bounds-validation-for-SMB-Direct-RDMA-desc.patch"
Content-Disposition: attachment; 
	filename="0001-ksmbd-add-bounds-validation-for-SMB-Direct-RDMA-desc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpju33f60>
X-Attachment-Id: f_mpju33f60

RnJvbSA4NmRiMGVlNTU3MzMyZDU3ZDIyNTk0NWEyMTkzYjVjOWY3N2E0YjNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOZ3V5ZW4gVmFuIFR1YW4gPGFubzEzdnhAZ21haWwuY29tPgpE
YXRlOiBTYXQsIDIzIE1heSAyMDI2IDE3OjE3OjM4ICswMDAwClN1YmplY3Q6IFtQQVRDSF0ga3Nt
YmQ6IGFkZCBib3VuZHMgdmFsaWRhdGlvbiBmb3IgU01CIERpcmVjdCBSRE1BIGRlc2NyaXB0b3Jz
CgpWYWxpZGF0ZSBvZmZzZXQsIGxlbmd0aCwgYW5kIGRlc2NfbGVuIGZpZWxkcyBvZiB0aGUgU01C
IERpcmVjdCBidWZmZXIKZGVzY3JpcHRvciBiZWZvcmUgcGFzc2luZyB0aGVtIHRvIHRoZSBSRE1B
IHRyYW5zcG9ydCBsYXllci4gV2l0aG91dAp0aGlzIGNoZWNrLCBhIHJlbW90ZSBhdHRhY2tlciBj
YW4gc3VwcGx5IGNyYWZ0ZWQgZGVzY3JpcHRvciB2YWx1ZXMgdG8KY2F1c2Ugb3V0LW9mLWJvdW5k
cyBtZW1vcnkgYWNjZXNzIGluIHRoZSB1bmRlcmx5aW5nIFJETUEgc3RhY2suCgpTaWduZWQtb2Zm
LWJ5OiBOZ3V5ZW4gVmFuIFR1YW4gPGFubzEzdnhAZ21haWwuY29tPgotLS0KIGZzL3NtYi9zZXJ2
ZXIvdHJhbnNwb3J0X3JkbWEuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZl
ci90cmFuc3BvcnRfcmRtYS5jIGIvZnMvc21iL3NlcnZlci90cmFuc3BvcnRfcmRtYS5jCmluZGV4
IGI2ZDYzZmY4YS4uZTEwNDE2YzBiIDEwMDY0NAotLS0gYS9mcy9zbWIvc2VydmVyL3RyYW5zcG9y
dF9yZG1hLmMKKysrIGIvZnMvc21iL3NlcnZlci90cmFuc3BvcnRfcmRtYS5jCkBAIC0yNjAsNiAr
MjYwLDExIEBAIHN0YXRpYyBpbnQgc21iX2RpcmVjdF9yZG1hX3dyaXRlKHN0cnVjdCBrc21iZF90
cmFuc3BvcnQgKnQsCiAgICAgc3RydWN0IHNtYl9kaXJlY3RfdHJhbnNwb3J0ICpzdCA9IFNNQkRf
VFJBTlModCk7CiAgICAgc3RydWN0IHNtYmRpcmVjdF9zb2NrZXQgKnNjID0gc3QtPnNvY2tldDsK
IAorCWludCByZXQ7CisKKwlyZXQgPSB2YWxpZGF0ZV9zbWJkX2Rlc2NyaXB0b3JfdjEoZGVzYywg
ZGVzY19sZW4sIGJ1Zmxlbik7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwogICAgIHJldHVy
biBzbWJkaXJlY3RfY29ubmVjdGlvbl9yZG1hX3htaXQoc2MsIGJ1ZiwgYnVmbGVuLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXNjLCBkZXNjX2xlbiwgZmFsc2UpOwogfQpAQCAtMjcwLDYg
KzI3NSwxMSBAQCBzdGF0aWMgaW50IHNtYl9kaXJlY3RfcmRtYV9yZWFkKHN0cnVjdCBrc21iZF90
cmFuc3BvcnQgKnQsCiAgICAgc3RydWN0IHNtYl9kaXJlY3RfdHJhbnNwb3J0ICpzdCA9IFNNQkRf
VFJBTlModCk7CiAgICAgc3RydWN0IHNtYmRpcmVjdF9zb2NrZXQgKnNjID0gc3QtPnNvY2tldDsK
IAorCWludCByZXQ7CisKKwlyZXQgPSB2YWxpZGF0ZV9zbWJkX2Rlc2NyaXB0b3JfdjEoZGVzYywg
ZGVzY19sZW4sIGJ1Zmxlbik7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwogICAgIHJldHVy
biBzbWJkaXJlY3RfY29ubmVjdGlvbl9yZG1hX3htaXQoc2MsIGJ1ZiwgYnVmbGVuLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXNjLCBkZXNjX2xlbiwgdHJ1ZSk7CiB9CkBAIC01NDEsMyAr
NTUxLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga3NtYmRfdHJhbnNwb3J0X29wcyBrc21iZF9z
bWJfZGlyZWN0X3RyYW5zcG9ydF9vcHMgPSB7CiAKIE1PRFVMRV9JTVBPUlRfTlMoIlNNQkRJUkVD
VCIpOwogCitzdGF0aWMgaW50IHZhbGlkYXRlX3NtYmRfZGVzY3JpcHRvcl92MShzdHJ1Y3Qgc21i
ZGlyZWN0X2J1ZmZlcl9kZXNjcmlwdG9yX3YxICpkZXNjLAorCQkJCSAgICAgICB1bnNpZ25lZCBp
bnQgZGVzY19sZW4sCisJCQkJICAgICAgIHVuc2lnbmVkIGludCBidWZsZW4pCit7CisJaWYgKGRl
c2NfbGVuIDwgc2l6ZW9mKHN0cnVjdCBzbWJkaXJlY3RfYnVmZmVyX2Rlc2NyaXB0b3JfdjEpKQor
CQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAoZGVzYy0+bGVuZ3RoID09IDAgfHwgZGVzYy0+bGVuZ3Ro
ID4gYnVmbGVuKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAoZGVzYy0+bGVuZ3RoID4gc21iX2Rp
cmVjdF9tYXhfcmVhZF93cml0ZV9zaXplKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlyZXR1cm4gMDsK
K30KLS0gCjIuNDMuMAo=
--0000000000007a35120652908b85--

