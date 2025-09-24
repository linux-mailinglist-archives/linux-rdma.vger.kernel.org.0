Return-Path: <linux-rdma+bounces-13614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BCB98658
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DA37B2E3C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 06:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5111242D90;
	Wed, 24 Sep 2025 06:33:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBF2222A1;
	Wed, 24 Sep 2025 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695613; cv=none; b=Mk4kHrmk2PUaFSzUrkFQ9jVStkFSyB45Xut36L7oml2AJ1tdaaRalXTH6iGV492y2s+2naodTE5epiHGi1N+7lnWIoWRAudF28Dt8p/Dy9FYHBOc0ok0FqRtxbZD4xckRnGN8+Aw3ELlUkyfChmYbfDK7USIwgr12O0N9Ev+VgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695613; c=relaxed/simple;
	bh=y90TwCpxCejDqeyztBDme0OflyAWgZRY8YwFu5i1bmQ=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=W5xW7TSlUlFNKCsfjgRgCV8zegmNuvjbMTnYmC12tayec6cAd+YEMOS6z5Y6Rnt9GW5McM6XQNGiIS/Jpy+23uK/hrgNyLTIzbotUBruQnZlOeBtc4ydZtx2L5GOcyalU26h1AT6wuslJSVuMf6f401j5dpUbvcjdm+jOMKEOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f784128991011f08b9f7d2eb6caa7cf-20250924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:40a5bb51-77e1-4a67-abfc-45f6f33a0af1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:cdec42b57c8f2e229366970c54fb1ede,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102,TC:0,Content:0|51,EDM:-3,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5f784128991011f08b9f7d2eb6caa7cf-20250924
Received: from node1 [(10.44.16.4)] by mailgw.kylinos.cn
	(envelope-from <daiyanlong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 788186720; Wed, 24 Sep 2025 14:33:24 +0800
Received: from node1 (localhost [127.0.0.1])
	by node1 (NSMail) with SMTP id A8F2A43001F80;
	Wed, 24 Sep 2025 14:33:24 +0800 (CST)
Received: by node1 (NSMail, from userid 10001)
	id A050543001F80; Wed, 24 Sep 2025 14:33:24 +0800 (CST)
From: =?UTF-8?B?5Luj5b2m6b6Z?= <daiyanlong@kylinos.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiByZG1hLXJjXSBSRE1BL2JueHRfcmU6IEZpeCBhIHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbiBkZXN0cm95X2dzaV9zcXA=?=
To: =?UTF-8?B?S2FsZXNoIEFuYWtrdXIgUHVyYXlpbA==?= <kalesh-anakkur.purayil@broadcom.com>
Cc: =?UTF-8?B?amdn?= <jgg@ziepe.ca>,
	=?UTF-8?B?bGVvbg==?= <leon@kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?bGludXgtcmRtYQ==?= <linux-rdma@vger.kernel.org>,
	=?UTF-8?B?c2VsdmluLnhhdmllcg==?= <selvin.xavier@broadcom.com>,
	=?UTF-8?B?ZHlsX3dsYw==?= <dyl_wlc@163.com>
Date: Wed, 24 Sep 2025 14:33:24 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <4fh5fbn3q13d-4fhbt0q6z5ze@nsmail8.2--kylin--1>
References: CAH-L+nOBvxMLWwiCZ9ZMj3TWozDkxQ9oCT_4A7V22Z1J0OQLMg@mail.gmail.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 24 Sep 2025 14:33:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-4hu3so4fd4i4-4hu81suhj7rh
X-ns-mid: webmail-68d390b4-4g0dpfge
X-ope-from: <daiyanlong@kylinos.cn>
X-receipt: 0

This message is in MIME format.

--nsmail-4hu3so4fd4i4-4hu81suhj7rh
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+SGVsbG8gU2VsdmluLCBLYWxlc2gsIExpc3QsPC9wPgo8cD5U
aGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciBwYXRpZW5jZSBhbmQgZ3VpZGFu
Y2UgdGhyb3VnaG91dCB0aGlzIHByb2Nlc3MuIEkgdHJ1bHkgYXBwcmVjaWF0
ZSB5b3UgdGFraW5nIHRoZSB0aW1lIHRvIHJldmlldyBteSBwYXRjaGVzIGFu
ZCBwcm92aWRlIGRldGFpbGVkIGZlZWRiYWNrIC0gaXQgaGFzIGJlZW4gYSBn
cmVhdCBsZWFybmluZyBleHBlcmllbmNlLjwvcD4KPHA+SSBoYXZlIGluY29y
cG9yYXRlZCBhbGwgb2YgeW91ciBzdWdnZXN0aW9ucyBpbiB0aGlzIHYyIHZl
cnNpb246PGJyPi0gQWRkZWQgdGhlICJyZG1hLXJjIiB0YXJnZXQgdHJlZSBw
cmVmaXggaW4gdGhlIHN1YmplY3QgbGluZTxicj4tIFVzZWQgcHJvcGVyIHZl
cnNpb24gbnVtYmVyaW5nICh2Mik8YnI+LSBJbmNsdWRlZCB0aGUgY2hhbmdl
bG9nIGJlbG93IHRoZSAnLS0tJyBsaW5lIGFzIHJlY29tbWVuZGVkPC9wPgo8
cD5UaGUgdXBkYXRlZCBwYXRjaCBpcyBhdHRhY2hlZC4gSSBiZWxpZXZlIGl0
IG5vdyBmb2xsb3dzIGFsbCB0aGUgcmVxdWlyZWQgZ3VpZGVsaW5lcy4gUGxl
YXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgZnVydGhlciBpc3N1
ZXMgb3IgYWRqdXN0bWVudHMgbmVlZGVkLjwvcD4KPHA+VGhlIHBhdGNoIGlz
IGFsc28gYXZhaWxhYmxlIG9uIGxvcmUua2VybmVsLm9yZyBoZXJlOjxicj48
YSBocmVmPSJodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA5MjQw
NjE0NDQuMTEyODgtMS1kYWl5YW5sb25nIj5odHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNTA5MjQwNjE0NDQuMTEyODgtMS1kYWl5YW5sb25nPC9h
PkBreWxpbm9zLmNuLzwvcD4KPHA+QmVzdCByZWdhcmRzLDxicj5ZYW5Mb25n
IERhaTwvcD4KPHA+Jm5ic3A7PC9wPgo8cD4tLS08L3A+CjxkaXYgaWQ9InNp
Z25hdHVyZVRvcCI+PC9kaXY+CjxkaXYgaWQ9ImNzMmNfcmUiIHN0eWxlPSJt
YXJnaW4tbGVmdDogMC41ZW07IHBhZGRpbmctbGVmdDogMC41ZW07IGJvcmRl
ci1sZWZ0OiAxcHggc29saWQgI2NhY2FjYTsgLXdlYmtpdC11c2VyLW1vZGlm
eTogcmVhZC1vbmx5OyAtbW96LXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7IC1t
cy11c2VyLW1vZGlmeTogcmVhZC1vbmx5OyAtby11c2VyLW1vZGlmeTogcmVh
ZC1vbmx5OyI+PGJyPjxicj48YnI+CjxkaXYgc3R5bGU9ImJhY2tncm91bmQt
Y29sb3I6ICNmOGY4Zjg7IHBhZGRpbmc6IDhweCAxMHB4OyBmb250LWZhbWls
eTogTWljcm9zb2Z0IFlhSGVpOyBmb250LXNpemU6IDE0cHg7IGNvbG9yOiAj
MDAwOyI+PHN0cm9uZz7kuLsmbmJzcDsmbmJzcDsmbmJzcDvpopjvvJo8L3N0
cm9uZz48c3BhbiBpZD0iY3MyY19zdWJqZWN0Ij5SZTogW1BBVENIXSBSRE1B
L2JueHRfcmU6IEZpeCBhIHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbiBkZXN0
cm95X2dzaV9zcXA8L3NwYW4+IDxicj48c3Ryb25nPuaXpSZuYnNwOyZuYnNw
OyZuYnNwO+acn++8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX2RhdGUiPjIw
MjXlubQwOeaciDI05pelMTM6MDE8L3NwYW4+IDxicj48c3Ryb25nPuWPkeS7
tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX2Zyb20iPkthbGVzaCBB
bmFra3VyIFB1cmF5aWw8L3NwYW4+IDxicj48c3Ryb25nPuaUtuS7tuS6uu+8
mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX3RvIiBzdHlsZT0id29yZC1icmVh
azogYnJlYWstYWxsOyI+S2FsZXNoIEFuYWtrdXIgUHVyYXlpbDwvc3Bhbj4g
PGJyPjxzdHJvbmc+5oqE6YCB5Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9ImNz
MmNfdG8iIHN0eWxlPSJ3b3JkLWJyZWFrOiBicmVhay1hbGw7Ij5qZ2csbGVv
bixsaW51eC1rZXJuZWwsbGludXgtcmRtYSxzZWx2aW4ueGF2aWVyLGR5bF93
bGM8L3NwYW4+PC9kaXY+Cjxicj4KPGRpdiBpZD0iY3MyY19jb250ZW50Ij4K
PGRpdiBkaXI9Imx0ciI+CjxkaXYgZGlyPSJsdHIiPkhpJm5ic3A7WWFuTG9u
Zyw8L2Rpdj4KPGRpdiBkaXI9Imx0ciI+Jm5ic3A7PC9kaXY+CjxkaXYgZGly
PSJsdHIiPkZldyBnZW5lcmljJm5ic3A7Z3VpZGVsaW5lcy48YnI+CjxkaXY+
Jm5ic3A7PC9kaXY+CjxkaXY+MS4gWW91IHNob3VsZCBzZWxlY3QgYSB0YXJn
ZXQgdHJlZSBpbiB0aGUgc3ViamVjdCBwcmVmaXggYW5kIHNwZWNpZnkgYSBy
ZXZpc2lvbiBudW1iZXIuIFNpbmNlIHRoaXMgaXMgYSBidWcgZml4LCB0aGUg
dGFyZ2V0IHRyZWUgc2hvdWxkIGJlICJyZG1hLXJjIi48YnI+Mi4gV2hlbiB5
b3Ugc2VuZCBhbiB1cGRhdGVkIHZlcnNpb24gb2YgdGhlIHBhdGNoLCBwbGVh
c2UgbWVudGlvbiB2ZXJzaW9uIG51bWJlci4gQWxzbywgbWVudGlvbiB0aGUg
Y2hhbmdlcyBtYWRlIGluIGVhY2ggdmVyc2lvbi4gaS5lLiB1bmRlciAtLS0g
eW91IGNhbiBhZGQgZXh0cmEgaW5mbyB0aGF0IHdpbGwgbm90IGJlIGluY2x1
ZGVkIGluIHRoZSBhY3R1YWwgY29tbWl0LCBlLmcuIGNoYW5nZXMgYmV0d2Vl
biBlYWNoIHZlcnNpb24gb2YgcGF0Y2hlcy48L2Rpdj4KPGRpdj4mbmJzcDs8
L2Rpdj4KPGRpdj5PbmUgY29tbWVudCBpbiBsaW5lLjwvZGl2Pgo8L2Rpdj4K
PGJyPgo8ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250
YWluZXIiPgo8ZGl2IGNsYXNzPSJnbWFpbF9hdHRyIiBkaXI9Imx0ciI+T24g
TW9uLCBTZXAgMjIsIDIwMjUgYXQgNzo1M+KAr0FNIFlhbkxvbmcgRGFpICZs
dDs8YSBocmVmPSJtYWlsdG86ZGFpeWFubG9uZ0BreWxpbm9zLmNuIj5kYWl5
YW5sb25nQGt5bGlub3MuY248L2E+Jmd0OyB3cm90ZTo8L2Rpdj4KPGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHgg
MHB4IDBweCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCAjY2NjY2Nj
OyBwYWRkaW5nLWxlZnQ6IDFleDsiPkZyb206IGRhaXlhbmxvbmcgJmx0Ozxh
IGhyZWY9Im1haWx0bzpkYWl5YW5sb25nQGt5bGlub3MuY24iIHRhcmdldD0i
X2JsYW5rIiByZWw9Im5vb3BlbmVyIj5kYWl5YW5sb25nQGt5bGlub3MuY248
L2E+Jmd0Ozxicj48YnI+VGhlIGN1cnJlbnQgZXJyb3IgaGFuZGxpbmcgcGF0
aCBpbiBibnh0X3JlX2Rlc3Ryb3lfZ3NpX3NxcCgpIGNvdWxkIGxlYWQ8YnI+
dG8gYSByZXNvdXJjZSBsZWFrLiBXaGVuIGJueHRfcXBsaWJfZGVzdHJveV9x
cCgpIGZhaWxzLCB0aGUgZnVuY3Rpb248YnI+anVtcHMgdG8gdGhlICdmYWls
JyBsYWJlbCBhbmQgcmV0dXJucyBpbW1lZGlhdGVseSwgc2tpcHBpbmcgdGhl
IGNhbGw8YnI+dG8gYm54dF9xcGxpYl9mcmVlX3FwX3JlcygpLjxicj48YnI+
Q29udGludWUgdGhlIHJlc291cmNlIHRlYXJkb3duIGV2ZW4gaWYgYm54dF9x
cGxpYl9kZXN0cm95X3FwKCkgZmFpbHMsPGJyPndoaWNoIGFsaWducyB3aXRo
IHRoZSBkcml2ZXIncyBnZW5lcmFsIGVycm9yIGhhbmRsaW5nIHN0cmF0ZWd5
IGFuZDxicj5wcmV2ZW50cyB0aGUgcG90ZW50aWFsIGxlYWsuPGJyPjxicj5G
aXhlczogOGRhZTQxOWY5ZWM3MyAoIlJETUEvYm54dF9yZTogUmVmYWN0b3Ig
cXVldWUgcGFpciBjcmVhdGlvbiBjb2RlIik8YnI+W0thbGVzaF0gQmxhbmsg
bGluZSBpcyBub3QgbmVlZGVkIGJldHdlZW4gRml4ZXMgdGFnIGFuZCBTT0Ig
dGFnPGJyPlNpZ25lZC1vZmYtYnk6IGRhaXlhbmxvbmcgJmx0OzxhIGhyZWY9
Im1haWx0bzpkYWl5YW5sb25nQGt5bGlub3MuY24iIHRhcmdldD0iX2JsYW5r
IiByZWw9Im5vb3BlbmVyIj5kYWl5YW5sb25nQGt5bGlub3MuY248L2E+Jmd0
Ozxicj4tLS08YnI+Jm5ic3A7ZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRf
cmUvaWJfdmVyYnMuYyB8IDcgKystLS0tLTxicj4mbmJzcDsxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKTxicj48YnI+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlL2li
X3ZlcmJzLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9pYl92
ZXJicy5jPGJyPmluZGV4IDI2MGRjNjdiOGI4Ny4uMTVkM2Y1ZDVjMGVlIDEw
MDY0NDxicj4tLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9p
Yl92ZXJicy5jPGJyPisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0
X3JlL2liX3ZlcmJzLmM8YnI+QEAgLTkzMSwxMCArOTMxLDkgQEAgc3RhdGlj
IGludCBibnh0X3JlX2Rlc3Ryb3lfZ3NpX3NxcChzdHJ1Y3QgYm54dF9yZV9x
cCAqcXApPGJyPjxicj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgaWJk
ZXZfZGJnKCZhbXA7cmRldi0mZ3Q7aWJkZXYsICJEZXN0cm95IHRoZSBzaGFk
b3cgUVBcbiIpOzxicj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgcmMg
PSBibnh0X3FwbGliX2Rlc3Ryb3lfcXAoJmFtcDtyZGV2LSZndDtxcGxpYl9y
ZXMsICZhbXA7Z3NpX3NxcC0mZ3Q7cXBsaWJfcXApOzxicj4tJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7aWYgKHJjKSB7PGJyPismbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDtpZiAocmMpPGJyPiZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgaWJkZXZfZXJy
KCZhbXA7cmRldi0mZ3Q7aWJkZXYsICJEZXN0cm95IFNoYWRvdyBRUCBmYWls
ZWQiKTs8YnI+LSZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDtnb3RvIGZhaWw7PGJyPi0mbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDt9PGJyPis8YnI+Jm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7IGJueHRfcXBsaWJfZnJlZV9xcF9yZXMoJmFtcDtyZGV2LSZn
dDtxcGxpYl9yZXMsICZhbXA7Z3NpX3NxcC0mZ3Q7cXBsaWJfcXApOzxicj48
YnI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IC8qIHJlbW92ZSBmcm9t
IGFjdGl2ZSBxcCBsaXN0ICovPGJyPkBAIC05NTEsOCArOTUwLDYgQEAgc3Rh
dGljIGludCBibnh0X3JlX2Rlc3Ryb3lfZ3NpX3NxcChzdHJ1Y3QgYm54dF9y
ZV9xcCAqcXApPGJyPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyByZGV2
LSZndDtnc2lfY3R4LnNxcF90YmwgPSBOVUxMOzxicj48YnI+Jm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7IHJldHVybiAwOzxicj4tZmFpbDo8YnI+LSZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO3JldHVybiByYzs8YnI+Jm5ic3A7
fTxicj48YnI+Jm5ic3A7LyogUXVldWUgUGFpcnMgKi88YnI+LS0gPGJyPjIu
NDMuMDxicj48YnI+PGJyPjwvYmxvY2txdW90ZT4KPC9kaXY+CjxkaXY+Jm5i
c3A7PC9kaXY+CjxkaXY+Jm5ic3A7PC9kaXY+CjxzcGFuIGNsYXNzPSJnbWFp
bF9zaWduYXR1cmVfcHJlZml4Ij4tLSA8L3NwYW4+PGJyPgo8ZGl2IGNsYXNz
PSJnbWFpbF9zaWduYXR1cmUiIGRpcj0ibHRyIj4KPGRpdiBkaXI9Imx0ciI+
UmVnYXJkcywKPGRpdj5LYWxlc2ggQVA8L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8
L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8cD4mbmJzcDs8L3A+CjxwPiZuYnNwOzwv
cD4KPGRpdiBpZD0ic2lnbmF0dXJlQm9tIj4KPGRpdj4KPHA+Jm5ic3A7PC9w
Pgo8YnI+CjxwIHN0eWxlPSJjb2xvcjogIzAwMDsgZm9udC1zaXplOiAxNnB4
OyI+LS0tPC9wPgo8ZGl2IGlkPSJjczJjX21haWxfc2lnYXR1cmUiIHN0eWxl
PSJjb2xvcjogIzAwMDsgZm9udC1zaXplOiAxNnB4OyBmb250LWZhbWlseTog
TWljcm9zb2Z0IFlhSGVpOyI+PC9kaXY+CjxwPiZuYnNwOzwvcD4KPC9kaXY+
CjwvZGl2PjwvZGl2Pg==

--nsmail-4hu3so4fd4i4-4hu81suhj7rh--

