Return-Path: <linux-rdma+bounces-13612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C345B98234
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 05:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5993A2B0B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 03:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08250225785;
	Wed, 24 Sep 2025 03:30:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE822DF9E;
	Wed, 24 Sep 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684610; cv=none; b=eWUVGRDq6W1KJ9LgHb7rSGiQZSZLZfQeaiz79pCJbsAoes/jtCovwpQvplZKEKC+61F9IbluHCtf59ruVI1plCkyFE5CqHm25b4hMtj7lD9MwlQfTCHeGSSENBpmDy8ynVnxvUyUYWTOLQh2ecUgsb4zvLBwXFIiKVgZaq+COls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684610; c=relaxed/simple;
	bh=mC5G8/c7XmbarhMqgxAR+zzK5m3RmNWe+wkCuPuMlO0=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=mId2JPdDzRymr4PgmvarxrM7x49E+JuEgjAe8f9eiU+IWJul2MwNysfeNaXvMkDFiz+toAl4eUGZjHrXKvokoogxGVVFlQvSwyw6F0NmF8N2HlyKmOo0EdhJXyTiNr+G0E101k3OePzBL52+lqTmcmGRlAeY6eDDDuApBCXJyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc762eb898f611f08b9f7d2eb6caa7cf-20250924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d5924a4a-45c6-4f72-9faa-13bc751d5034,IP:0,U
	RL:0,TC:-7,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-12
X-CID-META: VersionHash:6493067,CLOUDID:1c821660fbfd41d1344e50efed819307,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102,TC:1,Content:0|51,EDM:-3,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: bc762eb898f611f08b9f7d2eb6caa7cf-20250924
Received: from node1 [(10.44.16.4)] by mailgw.kylinos.cn
	(envelope-from <daiyanlong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 766256814; Wed, 24 Sep 2025 11:29:53 +0800
Received: from node1 (localhost [127.0.0.1])
	by node1 (NSMail) with SMTP id BF88843001F80;
	Wed, 24 Sep 2025 11:29:53 +0800 (CST)
Received: by node1 (NSMail, from userid 10001)
	id B78AE43001F80; Wed, 24 Sep 2025 11:29:53 +0800 (CST)
From: =?UTF-8?B?5Luj5b2m6b6Z?= <daiyanlong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIIHJkbWEtcmNdIFJETUEvYm54dF9yZTogRml4IGEgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGluIGRlc3Ryb3lfZ3NpX3NxcA==?=
To: =?UTF-8?B?TGVvbiBSb21hbm92c2t5?= <leon@kernel.org>
Cc: =?UTF-8?B?a2FsZXNoLWFuYWtrdXIucHVyYXlpbA==?= <kalesh-anakkur.purayil@broadcom.com>,
	=?UTF-8?B?amdn?= <jgg@ziepe.ca>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?bGludXgtcmRtYQ==?= <linux-rdma@vger.kernel.org>,
	=?UTF-8?B?c2VsdmluLnhhdmllcg==?= <selvin.xavier@broadcom.com>,
	=?UTF-8?B?ZHlsX3dsYw==?= <dyl_wlc@163.com>
Date: Wed, 24 Sep 2025 11:29:53 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <55mc6t88gc17-55mhuzizcgdo@nsmail8.2--kylin--1>
References: 20250921112854.GI10800@unreal
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 24 Sep 2025 11:29:53 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-58e29k738qum-58e5t64t1tkf
X-ns-mid: webmail-68d365b1-56614ojl
X-ope-from: <daiyanlong@kylinos.cn>
X-receipt: 0

This message is in MIME format.

--nsmail-58e29k738qum-58e5t64t1tkf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+Jm5ic3A7PC9wPgo8cD5IZWxsbyBLYWxlc2gsIFNlbHZpbiwg
TGlzdCw8L3A+CjxwPlRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrIG9uIG15
IHByZXZpb3VzIHBhdGNoIHJlZ2FyZGluZyB0aGUgZW1haWwgaWRlbnRpdHkg
aXNzdWUuIE15IGFwb2xvZ2llcyBmb3IgdGhhdCBvdmVyc2lnaHQuPC9wPgo8
cD5BcyBzdWdnZXN0ZWQsIEkgaGF2ZSBzdWJtaXR0ZWQgYSBuZXcsIHN0YW5k
YWxvbmUgcGF0Y2ggdG8gcmVwbGFjZSB0aGUgcHJldmlvdXMuIEluIHRoaXMg
bmV3IHN1Ym1pc3Npb24sIEkgaGF2ZSBlbnN1cmVkIGNvbnNpc3RlbnQgdXNl
IG9mIG15IGNvcnBvcmF0ZSBlbWFpbCBhZGRyZXNzIChkYWl5YW5sb25nQGt5
bGlub3MuY24pIGZvciBib3RoIGF1dGhvcnNoaXAgYW5kIHNpZ24tb2ZmLCBm
dWxmaWxsaW5nIHRoZSByZXF1aXJlbWVudCBpbiBgU3VibWl0dGluZy1wYXRj
aGVzLnJzdGAuPC9wPgo8cD5Db3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGUg
bmV3IHBhdGNoIGF0IHlvdXIgY29udmVuaWVuY2U/IFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB0aGVyZSBhcmUgYW55IGZ1cnRoZXIgaXNzdWVzLjwvcD4KPHA+
VGhhbmsgeW91IGZvciB5b3VyIGd1aWRhbmNlLjwvcD4KPHA+UmVmZXJlbmNl
czo8YnI+WzFdIE5ldyBwYXRjaDogPGEgaHJlZj0iaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjUwOTIyMDIyMjU1LjQ4MTgtMS1kYWl5YW5sb25n
Ij5odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA5MjIwMjIyNTUu
NDgxOC0xLWRhaXlhbmxvbmc8L2E+QGt5bGlub3MuY24vPC9wPgo8cD5CZXN0
IHJlZ2FyZHMsPGJyPllhbkxvbmcgRGFpPC9wPgo8ZGl2IGlkPSJzaWduYXR1
cmVUb3AiPjwvZGl2Pgo8ZGl2IGlkPSJjczJjX3JlIiBzdHlsZT0ibWFyZ2lu
LWxlZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVtOyBib3JkZXItbGVm
dDogMXB4IHNvbGlkICNjYWNhY2E7IC13ZWJraXQtdXNlci1tb2RpZnk6IHJl
YWQtb25seTsgLW1vei11c2VyLW1vZGlmeTogcmVhZC1vbmx5OyAtbXMtdXNl
ci1tb2RpZnk6IHJlYWQtb25seTsgLW8tdXNlci1tb2RpZnk6IHJlYWQtb25s
eTsiPjxicj48YnI+PGJyPgo8ZGl2IHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9y
OiAjZjhmOGY4OyBwYWRkaW5nOiA4cHggMTBweDsgZm9udC1mYW1pbHk6IE1p
Y3Jvc29mdCBZYUhlaTsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogIzAwMDsi
PjxzdHJvbmc+5Li7Jm5ic3A7Jm5ic3A7Jm5ic3A76aKY77yaPC9zdHJvbmc+
PHNwYW4gaWQ9ImNzMmNfc3ViamVjdCI+UmU6IFtQQVRDSCByZG1hLXJjXSBS
RE1BL2JueHRfcmU6IEZpeCBhIHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbiBk
ZXN0cm95X2dzaV9zcXA8L3NwYW4+IDxicj48c3Ryb25nPuaXpSZuYnNwOyZu
YnNwOyZuYnNwO+acn++8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX2RhdGUi
PjIwMjXlubQwOeaciDIx5pelMTk6Mjg8L3NwYW4+IDxicj48c3Ryb25nPuWP
keS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX2Zyb20iPkxlb24g
Um9tYW5vdnNreTwvc3Bhbj4gPGJyPjxzdHJvbmc+5pS25Lu25Lq677yaPC9z
dHJvbmc+PHNwYW4gaWQ9ImNzMmNfdG8iIHN0eWxlPSJ3b3JkLWJyZWFrOiBi
cmVhay1hbGw7Ij5ZYW5Mb25nIERhaSxMZW9uIFJvbWFub3Zza3k8L3NwYW4+
IDxicj48c3Ryb25nPuaKhOmAgeS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJj
czJjX3RvIiBzdHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+a2FsZXNo
LWFuYWtrdXIucHVyYXlpbCxqZ2csbGludXgta2VybmVsLGxpbnV4LXJkbWEs
c2VsdmluLnhhdmllcjwvc3Bhbj48L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjczJj
X2NvbnRlbnQiPk9uIEZyaSwgU2VwIDE5LCAyMDI1IGF0IDAxOjQyOjM4UE0g
KzA4MDAsIFlhbkxvbmcgRGFpIHdyb3RlOiAmZ3Q7IEZyb206IGRhaXlhbmxv
bmcgJmx0O2RhaXlhbmxvbmdAa3lsaW5vcy5jbiZndDsgJmd0OyAmZ3Q7IFRo
ZSBjdXJyZW50IGVycm9yIGhhbmRsaW5nIHBhdGggaW4gYm54dF9yZV9kZXN0
cm95X2dzaV9zcXAoKSBjb3VsZCBsZWFkICZndDsgdG8gYSByZXNvdXJjZSBs
ZWFrLiBXaGVuIGJueHRfcXBsaWJfZGVzdHJveV9xcCgpIGZhaWxzLCB0aGUg
ZnVuY3Rpb24gJmd0OyBqdW1wcyB0byB0aGUgJ2ZhaWwnIGxhYmVsIGFuZCBy
ZXR1cm5zIGltbWVkaWF0ZWx5LCBza2lwcGluZyB0aGUgY2FsbCAmZ3Q7IHRv
IGJueHRfcXBsaWJfZnJlZV9xcF9yZXMoKS4gJmd0OyAmZ3Q7IENvbnRpbnVl
IHRoZSByZXNvdXJjZSB0ZWFyZG93biBldmVuIGlmIGJueHRfcXBsaWJfZGVz
dHJveV9xcCgpIGZhaWxzLCAmZ3Q7IHdoaWNoIGFsaWducyB3aXRoIHRoZSBk
cml2ZXIncyBnZW5lcmFsIGVycm9yIGhhbmRsaW5nIHN0cmF0ZWd5IGFuZCAm
Z3Q7IHByZXZlbnRzIHRoZSBwb3RlbnRpYWwgbGVhay4gJmd0OyAmZ3Q7IEZp
eGVzOiA4ZGFlNDE5ZjllYzczICgiUkRNQS9ibnh0X3JlOiBSZWZhY3RvciBx
dWV1ZSBwYWlyIGNyZWF0aW9uIGNvZGUiKSAmZ3Q7ICZndDsgU2lnbmVkLW9m
Zi1ieTogZGFpeWFubG9uZyAmbHQ7ZGFpeWFubG9uZ0BreWxpbm9zLmNuJmd0
OyBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJz
dCAzOTYgU2lnbiB5b3VyIHdvcmsgLSB0aGUgRGV2ZWxvcGVyJ3MgQ2VydGlm
aWNhdGUgb2YgT3JpZ2luIDM5NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gMzk4IC4uLiA0NDAgdXNp
bmcgYSBrbm93biBpZGVudGl0eSAoc29ycnksIG5vIGFub255bW91cyBjb250
cmlidXRpb25zLikgVGhhbmtzICZndDsgLS0tICZndDsgZHJpdmVycy9pbmZp
bmliYW5kL2h3L2JueHRfcmUvaWJfdmVyYnMuYyB8IDcgKystLS0tLSAmZ3Q7
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pICZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2h3L2JueHRfcmUvaWJfdmVyYnMuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9ibnh0X3JlL2liX3ZlcmJzLmMgJmd0OyBpbmRleCAyNjBkYzY3YjhiODcu
LjE1ZDNmNWQ1YzBlZSAxMDA2NDQgJmd0OyAtLS0gYS9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvYm54dF9yZS9pYl92ZXJicy5jICZndDsgKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2JueHRfcmUvaWJfdmVyYnMuYyAmZ3Q7IEBAIC05
MzEsMTAgKzkzMSw5IEBAIHN0YXRpYyBpbnQgYm54dF9yZV9kZXN0cm95X2dz
aV9zcXAoc3RydWN0IGJueHRfcmVfcXAgKnFwKSAmZ3Q7ICZndDsgaWJkZXZf
ZGJnKCZhbXA7cmRldi0mZ3Q7aWJkZXYsICJEZXN0cm95IHRoZSBzaGFkb3cg
UVBcbiIpOyAmZ3Q7IHJjID0gYm54dF9xcGxpYl9kZXN0cm95X3FwKCZhbXA7
cmRldi0mZ3Q7cXBsaWJfcmVzLCAmYW1wO2dzaV9zcXAtJmd0O3FwbGliX3Fw
KTsgJmd0OyAtIGlmIChyYykgeyAmZ3Q7ICsgaWYgKHJjKSAmZ3Q7IGliZGV2
X2VycigmYW1wO3JkZXYtJmd0O2liZGV2LCAiRGVzdHJveSBTaGFkb3cgUVAg
ZmFpbGVkIik7ICZndDsgLSBnb3RvIGZhaWw7ICZndDsgLSB9ICZndDsgKyAm
Z3Q7IGJueHRfcXBsaWJfZnJlZV9xcF9yZXMoJmFtcDtyZGV2LSZndDtxcGxp
Yl9yZXMsICZhbXA7Z3NpX3NxcC0mZ3Q7cXBsaWJfcXApOyAmZ3Q7ICZndDsg
LyogcmVtb3ZlIGZyb20gYWN0aXZlIHFwIGxpc3QgKi8gJmd0OyBAQCAtOTUx
LDggKzk1MCw2IEBAIHN0YXRpYyBpbnQgYm54dF9yZV9kZXN0cm95X2dzaV9z
cXAoc3RydWN0IGJueHRfcmVfcXAgKnFwKSAmZ3Q7IHJkZXYtJmd0O2dzaV9j
dHguc3FwX3RibCA9IE5VTEw7ICZndDsgJmd0OyByZXR1cm4gMDsgJmd0OyAt
ZmFpbDogJmd0OyAtIHJldHVybiByYzsgJmd0OyB9ICZndDsgJmd0OyAvKiBR
dWV1ZSBQYWlycyAqLyAmZ3Q7IC0tICZndDsgMi40My4wICZndDsgJmx0Oy9k
YWl5YW5sb25nQGt5bGlub3MuY24mZ3Q7Jmx0Oy9kYWl5YW5sb25nQGt5bGlu
b3MuY24mZ3Q7PC9kaXY+CjwvZGl2Pgo8cD4mbmJzcDs8L3A+CjxwPiZuYnNw
OzwvcD4KPGRpdiBpZD0ic2lnbmF0dXJlQm9tIj4KPGRpdj4KPHA+Jm5ic3A7
PC9wPgo8YnI+CjxwIHN0eWxlPSJjb2xvcjogIzAwMDsgZm9udC1zaXplOiAx
NnB4OyI+LS0tPC9wPgo8ZGl2IGlkPSJjczJjX21haWxfc2lnYXR1cmUiIHN0
eWxlPSJjb2xvcjogIzAwMDsgZm9udC1zaXplOiAxNnB4OyBmb250LWZhbWls
eTogTWljcm9zb2Z0IFlhSGVpOyI+PC9kaXY+CjxwPiZuYnNwOzwvcD4KPC9k
aXY+CjwvZGl2PjwvZGl2Pg==

--nsmail-58e29k738qum-58e5t64t1tkf--

