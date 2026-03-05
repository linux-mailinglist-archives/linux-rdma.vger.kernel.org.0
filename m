Return-Path: <linux-rdma+bounces-17557-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFQZLvnRqWmYFgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17557-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 19:56:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 200622172C1
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 19:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41959308D3CE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1B2DCBFC;
	Thu,  5 Mar 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QelaV1uE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CB2DB7BF
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736892; cv=none; b=AwV+U4WLJDDVtf72DPdisVLpGfaYT4u98O5tAtviqqINZZiSQ5vkJoJpWi4gIiWspMcB6SEz7585Qr3BVqDCbg+/lOsZQ9Lngm968fg8uGwwHuC7VAjdOGjHcu0bCmHVdCAYow70lTTT1EsOsSFSV7cji5z3ep9SVoEq/aimT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736892; c=relaxed/simple;
	bh=R6xQbhNfptbrNKIcrhT4afalwvfBb3KOwNS54xIV0C8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=OqDzXUg3H27djDqcDZ2qG8bCItiX0wB6QNgK8gHk51fFQGf2aXDr1Xfh9lggOkPDCSB1vW+91UdOGpTDqSVgL9SQ2EK+9P3dbUgnAy10sdi3EwAsso3KxswfEOqQYRjQ6ox2QXjgs+SKuWaKLPB2jRYPTkCSXHfSkd+X1sJtdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QelaV1uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B00AC116C6;
	Thu,  5 Mar 2026 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736891;
	bh=R6xQbhNfptbrNKIcrhT4afalwvfBb3KOwNS54xIV0C8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QelaV1uEUSzCA7sbExEfdJqHmSYXB1NJYPDHKb7LY5EW75LjOKmKvrFJXdVL0g5nL
	 AEKa9nT9FCyjGDITW6xH+fRuP1WgAzQSW3cYgw4x41eobmR/cuYBWv1HtWACc/QHId
	 l1UtJtYIkIdPje3e7wAxTryf4ySvaUCnJuqOszA9RFVhIiujiu/41IV4tcJLyhDtBP
	 Vpgw5oE0J9vkh1Xng9pspDOnQ81A15mfmcQtmF/huVhQdlyMkC8uOGawToyHXllelr
	 erBqbNxJ8GeyhtD+YTyrsQLyEOOiDKU3XNr26x+Kvf56BzNVVzzfBSJVNhZcFkJ0UK
	 Qa69NUJZRXXhQ==
Content-Type: multipart/mixed; boundary="------------Z4wp4BikURQP7adhswvGpHVi"
Message-ID: <c6b20dd4-2f9e-45d2-9df7-0b15b22d3b5a@kernel.org>
Date: Thu, 5 Mar 2026 11:54:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260304041607.11685-1-yanjun.zhu@linux.dev>
X-Rspamd-Queue-Id: 200622172C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17557-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------Z4wp4BikURQP7adhswvGpHVi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 9:16 PM, Zhu Yanjun wrote:
> When run "ip link add" command to add a rxe rdma link in a net
> namespace, normally this rxe rdma link can not work in a net
> name space.
> 
> The root cause is that a sock listening on udp port 4791 is created
> in init_net when the rdma_rxe module is loaded into kernel. That is,
> the sock listening on udp port 4791 is created in init_net. Other net
> namespace is difficult to use this sock.
> 
> The following commits will solve this problem.

you squashed all of the changes into 1 commit, so either the commit
message needs to be fixed up or you need to do the patch series.

That said, I still think the optimizations around tracking the number of
devices in the namespace and closing the sockets are unncessary at this
time. It brings in complications to your set which is delaying the merge
of namespace support. If it is done, the socket refcount approach seems
problematic; how about a simpler approach with a device count in the
net_generic struct used per namespace (again, I really believe this
should be a follow on patch).

Also, claude has some comments about this patch. See attached. At this
point surely you have access to some AI model that can do code reviews.
There are prompts here https://github.com/masoncl/review-prompts.git
that can be leveraged as I did here.

--------------Z4wp4BikURQP7adhswvGpHVi
Content-Type: text/plain; charset=UTF-8; name="review-inline.txt"
Content-Disposition: attachment; filename="review-inline.txt"
Content-Transfer-Encoding: base64

Y29tbWl0IDA0YjBhYjI1YmQ5NGM2MTAwNDAxZDUyYWQ2NjlmZDIxYzQwNjVkMmYKQXV0aG9y
OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4KClJETUEvcnhlOiBBZGQgdGhl
IHN1cHBvcnQgdGhhdCByeGUgY2FuIHdvcmsgaW4gbmV0IG5hbWVzcGFjZQoKVGhpcyBjb21t
aXQgYWRkcyBwZXItbmFtZXNwYWNlIFVEUCBzb2NrZXQgbWFuYWdlbWVudCBmb3IgdGhlIHJ4
ZQpzb2Z0IFJvQ0UgZHJpdmVyLCBtb3Zpbmcgc29ja2V0IGNyZWF0aW9uIGZyb20gbW9kdWxl
IGluaXQgdG8gcGVyLWxpbmsKY3JlYXRpb24gYW5kIGFkZGluZyBwZXJuZXRfb3BlcmF0aW9u
cyB0byB0cmFjayBzb2NrZXRzIHBlciBuYW1lc3BhY2UuCgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9uZXQuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX25ldC5jCgpbIC4uLiBdCgo+ICsjZGVmaW5lIFNLX1JFRl9GT1JfVFVOTkVM
CTIKPiArCj4gK3N0YXRpYyB2b2lkIHJ4ZV9zb2NrX3B1dChzdHJ1Y3Qgc29jayAqc2ssCj4g
KwkJCQl2b2lkICgqc2V0X3NrKShzdHJ1Y3QgbmV0ICosIHN0cnVjdCBzb2NrICopLAo+ICsJ
CQkJc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpCj4gK3sKPiArCWlmIChyZWZjb3VudF9yZWFk
KCZzay0+c2tfcmVmY250KSA+IFNLX1JFRl9GT1JfVFVOTkVMKSB7Cj4gKwkJX19zb2NrX3B1
dChzayk7Cj4gKwl9IGVsc2Ugewo+ICsJCXJ4ZV9yZWxlYXNlX3VkcF90dW5uZWwoc2stPnNr
X3NvY2tldCk7Cj4gKwkJc2sgPSBOVUxMOwo+ICsJCXNldF9zayhkZXZfbmV0KG5kZXYpLCBz
ayk7Cj4gKwl9Cj4gK30KCkRvZXMgU0tfUkVGX0ZPUl9UVU5ORUwgaGF2ZSB0aGUgcmlnaHQg
dmFsdWUgaGVyZT8KClRoZSBzb2NrZXQgY3JlYXRlZCBieSByeGVfc2V0dXBfdWRwX3R1bm5l
bCgpIHN0YXJ0cyB3aXRoIHNrX3JlZmNudD0xCihza19hbGxvYyBzZXRzIHJlZmNvdW50X3Nl
dCgmc2stPnNrX3JlZmNudCwgMSksIGFuZCBzZXR1cF91ZHBfdHVubmVsX3NvY2sKZG9lcyBu
b3QgYWRkIGEgcmVmZXJlbmNlKS4gVGhlIHNlY29uZCBsaW5rIGNhbGxpbmcgc29ja19ob2xk
KCkgaW4KcnhlX25ldF9pcHY0X2luaXQoKSBicmluZ3MgdGhlIGNvdW50IHRvIDIuCgpXaXRo
IHRoZSB0aHJlc2hvbGQgYXQgMiwgd2hlbiB0aGUgZmlyc3Qgb2YgdHdvIGFjdGl2ZSBsaW5r
cyBpcyBkZWxldGVkOgoKICAgIHJ4ZV9zb2NrX3B1dCgpOgogICAgICAgIHJlZmNvdW50X3Jl
YWQoJnNrLT5za19yZWZjbnQpID09IDIKICAgICAgICAyID4gU0tfUkVGX0ZPUl9UVU5ORUwo
MikgaXMgZmFsc2UKICAgICAgICA9PiByeGVfcmVsZWFzZV91ZHBfdHVubmVsKHNrLT5za19z
b2NrZXQpCgpUaGlzIGNhbGxzIHVkcF90dW5uZWxfc29ja19yZWxlYXNlKCksIHdoaWNoIGNs
ZWFycyB0aGUgZW5jYXBfcmN2IGhhbmRsZXIKYW5kIGNhbGxzIHNvY2tfcmVsZWFzZSgpLiBU
aGUgc2Vjb25kIGxpbmsncyBzb2NrZXQgaXMgbm93IHNodXQgZG93biB3aGlsZQpzdGlsbCBp
biB1c2UuCgpTaG91bGRuJ3QgU0tfUkVGX0ZPUl9UVU5ORUwgYmUgMSBzbyB0aGF0IHRoZSB0
dW5uZWwgaXMgb25seSByZWxlYXNlZCB3aGVuCnRoZSBsYXN0IGxpbmsgaXMgcmVtb3ZlZD8K
Cj4gK3ZvaWQgcnhlX25ldF9kZWwoc3RydWN0IGliX2RldmljZSAqZGV2KQo+ICt7Cj4gKwlz
dHJ1Y3Qgc29jayAqc2s7Cj4gKwlzdHJ1Y3QgcnhlX2RldiAqcnhlOwo+ICsJc3RydWN0IG5l
dF9kZXZpY2UgKm5kZXY7Cj4gKwo+ICsJcnhlID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0
IHJ4ZV9kZXYsIGliX2Rldik7Cj4gKwo+ICsJbmRldiA9IHJ4ZV9pYl9kZXZpY2VfZ2V0X25l
dGRldigmcnhlLT5pYl9kZXYpOwo+ICsJaWYgKCFuZGV2KQo+ICsJCXJldHVybjsKPiArCj4g
KwlzayA9IHJ4ZV9uc19wZXJuZXRfc2s0KGRldl9uZXQobmRldikpOwo+ICsJaWYgKCFzaykK
PiArCQlnb3RvIGVycl9vdXQ7Cj4gKwo+ICsJcnhlX3NvY2tfcHV0KHNrLCByeGVfbnNfcGVy
bmV0X3NldF9zazQsIG5kZXYpOwo+ICsKPiArCXNrID0gcnhlX25zX3Blcm5ldF9zazYoZGV2
X25ldChuZGV2KSk7Cj4gKwlpZiAoIXNrKQo+ICsJCWdvdG8gZXJyX291dDsKPiArCj4gKwly
eGVfc29ja19wdXQoc2ssIHJ4ZV9uc19wZXJuZXRfc2V0X3NrNiwgbmRldik7Cj4gKwo+ICtl
cnJfb3V0Ogo+ICsJZGV2X3B1dChuZGV2KTsKPiArfQoKV2hlbiBzazQgaXMgTlVMTCwgdGhl
IGdvdG8gZXJyX291dCBza2lwcyB0aGUgc2s2IGNsZWFudXAgZW50aXJlbHkuIENhbgpzazYg
YmUgbm9uLU5VTEwgd2hlbiBzazQgaXMgTlVMTD8gRm9yIGV4YW1wbGUsIGFmdGVyIHJ4ZV9z
b2NrX3B1dCgpIHNldHMKdGhlIHBlcm5ldCBzazQgdG8gTlVMTCAodmlhIHNldF9zaygpKSB3
aGlsZSBhIGNvbmN1cnJlbnQgb3BlcmF0aW9uIGxlYXZlcwpzazYgbm9uLU5VTEwuCgo+IC1p
bnQgcnhlX25ldF9pbml0KHZvaWQpCj4gK2ludCByeGVfbmV0X2luaXQoc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYpCj4gIHsKPiAgCWludCBlcnI7Cj4KPiAtCXJlY3Zfc29ja2V0cy5zazYg
PSBOVUxMOwo+IC0KPiAtCWVyciA9IHJ4ZV9uZXRfaXB2NF9pbml0KCk7Cj4gKwllcnIgPSBy
eGVfbmV0X2lwdjRfaW5pdChuZGV2KTsKPiAgCWlmIChlcnIpCj4gIAkJcmV0dXJuIGVycjsK
PiAtCWVyciA9IHJ4ZV9uZXRfaXB2Nl9pbml0KCk7Cj4gKwo+ICsJZXJyID0gcnhlX25ldF9p
cHY2X2luaXQobmRldik7Cj4gIAlpZiAoZXJyKQo+ICAJCWdvdG8gZXJyX291dDsKPiAgCXJl
dHVybiAwOwo+ICsKPiAgZXJyX291dDoKPiArCS8qIElmIGlwdjYgZXJyb3IsIHJlbGVhc2Ug
aXB2NCByZXNvdXJjZSAqLwo+ICsJdWRwX3R1bm5lbF9zb2NrX3JlbGVhc2UocnhlX25zX3Bl
cm5ldF9zazQoZGV2X25ldChuZGV2KSktPnNrX3NvY2tldCk7Cj4gKwlyeGVfbnNfcGVybmV0
X3NldF9zazQoZGV2X25ldChuZGV2KSwgTlVMTCk7Cj4gIAlyeGVfbmV0X2V4aXQoKTsKPiAg
CXJldHVybiBlcnI7Cj4gIH0KClRoZSBjYWxsIHRvIHJ4ZV9uZXRfZXhpdCgpIGluIHRoZSBl
cnJvciBwYXRoIGxvb2tzIGxpa2UgaXQgd2FzIGNhcnJpZWQgb3Zlcgpmcm9tIHRoZSBvbGQg
Y29kZSBidXQgaXMgbm8gbG9uZ2VyIGNvcnJlY3QuCgpJbiB0aGUgb2xkIGNvZGUgcnhlX25l
dF9pbml0KCkgcmVnaXN0ZXJlZCB0aGUgbmV0ZGV2IG5vdGlmaWVyIGl0c2VsZiwgc28KY2Fs
bGluZyByeGVfbmV0X2V4aXQoKSBvbiBmYWlsdXJlIHdhcyB0aGUgcmlnaHQgY2xlYW51cC4g
SW4gdGhlIG5ldyBjb2RlCnRoZSBub3RpZmllciBpcyByZWdpc3RlcmVkIG9uY2UgYXQgbW9k
dWxlIGxvYWQgaW4gcnhlX3JlZ2lzdGVyX25vdGlmaWVyKCk6CgogICAgcnhlX21vZHVsZV9p
bml0KCkKICAgICAgICByeGVfcmVnaXN0ZXJfbm90aWZpZXIoKQogICAgICAgICAgICByZWdp
c3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXIoJnJ4ZV9uZXRfbm90aWZpZXIpICAvKiBtb2R1bGUt
d2lkZSAqLwoKICAgIHJ4ZV9uZXRfaW5pdCgpICAvKiBjYWxsZWQgcGVyIGxpbmsgZnJvbSBy
eGVfbmV3bGluaygpICovCiAgICAgICAgcnhlX25ldF9pcHY0X2luaXQoKQogICAgICAgIHJ4
ZV9uZXRfaXB2Nl9pbml0KCkgIC8qIGZhaWxzICovCiAgICBlcnJfb3V0OgogICAgICAgIHJ4
ZV9uZXRfZXhpdCgpCiAgICAgICAgICAgIHVucmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVy
KCZyeGVfbmV0X25vdGlmaWVyKSAgLyogb29wcyAqLwoKSWYgcnhlX25ldF9pcHY2X2luaXQo
KSBmYWlscyBmb3IgYW55IGxpbmsgY3JlYXRpb24gYXR0ZW1wdCAoZS5nLiwgLUVOT01FTQpm
cm9tIHVkcF9zb2NrX2NyZWF0ZSksIHRoZSBtb2R1bGUtbGV2ZWwgbm90aWZpZXIgaXMgdW5y
ZWdpc3RlcmVkLiBBZnRlcgp0aGF0LCBORVRERVZfVU5SRUdJU1RFUiwgTkVUREVWX0NIQU5H
RU1UVSBhbmQgb3RoZXIgZXZlbnRzIGFyZSBzaWxlbnRseQppZ25vcmVkIGZvciBhbGwgZXhp
c3RpbmcgcnhlIGRldmljZXMuCgpTaG91bGQgdGhlIGVycl9vdXQgcGF0aCBjYWxsIHJ4ZV9u
ZXRfZXhpdCgpIGF0IGFsbCwgZ2l2ZW4gdGhhdApyeGVfbmV0X2V4aXQoKSBpcyBub3cgb25s
eSByZXNwb25zaWJsZSBmb3IgdW5yZWdpc3RlcmluZyB0aGUgZ2xvYmFsCm5vdGlmaWVyPwoK
VGhlIHNhbWUgZXJyb3IgcGF0aCBhbHNvIGNhbGxzIHVkcF90dW5uZWxfc29ja19yZWxlYXNl
KCkgdW5jb25kaXRpb25hbGx5Cm9uIHRoZSBJUHY0IHNvY2tldC4gV2hlbiByeGVfbmV0X2lw
djRfaW5pdCgpIGZvdW5kIGFuIGV4aXN0aW5nIHNvY2tldCBhbmQKY2FsbGVkIHNvY2tfaG9s
ZCgpIHJhdGhlciB0aGFuIGNyZWF0aW5nIGEgbmV3IG9uZSwgY2FsbGluZwp1ZHBfdHVubmVs
X3NvY2tfcmVsZWFzZSgpIHRlYXJzIGRvd24gYSBzb2NrZXQgdGhhdCBiZWxvbmdzIHRvIGFu
IGFscmVhZHkKYWN0aXZlIGxpbmsuIFNob3VsZCB0aGUgSVB2NCBjbGVhbnVwIGRpc3Rpbmd1
aXNoIGJldHdlZW4gdGhlIHNvY2tfaG9sZApjYXNlIGFuZCB0aGUgc29ja2V0IGNyZWF0aW9u
IGNhc2U/Cgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5j
IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYwoKWyAuLi4gXQoKPiArCXJkbWFf
bGlua19yZWdpc3RlcigmcnhlX2xpbmtfb3BzKTsKPiArCWVyciA9IHJ4ZV9yZWdpc3Rlcl9u
b3RpZmllcigpOwo+ICAJaWYgKGVycikgewo+ICsJCXByX2VycigiRmFpbGVkIHRvIHJlZ2lz
dGVyIG5ldGRldiBub3RpZmllclxuIik7Cj4gIAkJcnhlX2Rlc3Ryb3lfd3EoKTsKPiAtCQly
ZXR1cm4gZXJyOwo+ICsJCXJldHVybiAtMTsKPiAgCX0KPiArCj4gKwllcnIgPSByeGVfbmFt
ZXNwYWNlX2luaXQoKTsKPiAgCWlmIChlcnIpIHsKPiArCQlwcl9lcnIoIkZhaWxlZCB0byBy
ZWdpc3RlciBuZXQgbmFtZXNwYWNlIG5vdGlmaWVyXG4iKTsKPiArCQlyZXR1cm4gLTE7Cj4g
IAl9CgpJZiByeGVfbmFtZXNwYWNlX2luaXQoKSBmYWlscywgcmRtYV9saW5rX3JlZ2lzdGVy
KCkgYW5kCnJ4ZV9yZWdpc3Rlcl9ub3RpZmllcigpIGFyZSBub3QgdW5kb25lIGJlZm9yZSB0
aGUgbW9kdWxlIGluaXQgcmV0dXJucwphbiBlcnJvci4gU2luY2UgdGhlIGtlcm5lbCBkb2Vz
IG5vdCBjYWxsIG1vZHVsZV9leGl0IHdoZW4gbW9kdWxlX2luaXQKZmFpbHMsIHJkbWFfbGlu
a191bnJlZ2lzdGVyKCksIHJ4ZV9uZXRfZXhpdCgpIGFuZCByeGVfZGVzdHJveV93cSgpIGFy
ZQpuZXZlciBjYWxsZWQuCgpBbHNvLCBib3RoIGVycm9yIHJldHVybnMgdXNlIC0xIHJhdGhl
ciB0aGFuIHByb3BhZ2F0aW5nIGVyciBvciBhIHByb3BlcgplcnJuby4gLTEgbWFwcyB0byBF
UEVSTSB3aGljaCBpcyBtaXNsZWFkaW5nIGZvciBhIHJlZ2lzdHJhdGlvbiBmYWlsdXJlLgoK


--------------Z4wp4BikURQP7adhswvGpHVi--

