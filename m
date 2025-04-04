Return-Path: <linux-rdma+bounces-9159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9623A7C0C2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B29A189EF9A
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BCC1F7545;
	Fri,  4 Apr 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hoffmanne.cfd header.i=@hoffmanne.cfd header.b="OYbxuLb6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hoffmanne.cfd (unknown [147.189.135.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE61F6699
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.189.135.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781174; cv=none; b=nd0XLjn19qp4FzM1kh45sj8VHX1F0rJst2eLeUd4fEkS+kXqwodNydQfu93NM0SACKJIDOBTKo0Tg/tjqOjMgozP+EqvRVMNk6h1d7sOZZvpKcObYcra18GR++ryoqTiVf6vP2bE798lducsPPwkxRlsIpxvD/ylfeGCt8T8KcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781174; c=relaxed/simple;
	bh=mHeYRDwC4NhciizZuecHzxK9iWdyRDejpuC320chxBI=;
	h=To:Subject:Date:From:Message-ID:MIME-Version:Content-Type; b=LM4qEmpcYdUOQSiNkJZz+k3kQWyXXbAGWVWr753z3a0HdiohVAQ3yMSizKAkPIUvnfmp/UMvEqEKAu1RXQFh32H/h0SCrqsXBTqmpMLsCF+KqSBcYPr6HyBEzhEW6cDBendxJ67mxUtxa+/Y/bc0BmIuDZnuO5HI9VcuJrnU8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hoffmanne.cfd; spf=pass smtp.mailfrom=hoffmanne.cfd; dkim=pass (1024-bit key) header.d=hoffmanne.cfd header.i=@hoffmanne.cfd header.b=OYbxuLb6; arc=none smtp.client-ip=147.189.135.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hoffmanne.cfd
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hoffmanne.cfd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=hoffmanne.cfd; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Reply-To:From:Date:Subject:To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z+jxu593huLKFZv29O/DLCCNgNWQ/coI90ZKUuN2XRk=; b=OYbxuLb6ez/823+Y7jwD6rtqXx
	3xizCJ14+dm9ooKb25jgJZpuO6ID3Kt791h1CvsZZLZSb8GB0Elueo4Y5sYHkiRuu9nAFKzHsQLfg
	E3GPODARL1Tuk34nkwNnlgNKdWylKiYJGVvDfKRjbgjjgmpCViGq0NlHJ27mZN1GNK3Y=;
Received: from admin by hoffmanne.cfd with local (Exim 4.90_1)
	(envelope-from <support@hoffmanne.cfd>)
	id 1u0h8N-0005sd-MC
	for linux-rdma@vger.kernel.org; Fri, 04 Apr 2025 13:30:59 +0000
To: linux-rdma@vger.kernel.org
Subject: WTS Available laptops and Memory
Date: Fri, 4 Apr 2025 13:30:59 +0000
From: Charles Lawson <support@hoffmanne.cfd>
Reply-To: sales@exceptionalonepc.com
Message-ID: <6039d86d0659d6af2af09c0f06d28ba6@hoffmanne.cfd>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello ,

These are available for sale. If you’re interested in purchasing these, please email me



NVIDIA GeForce RTX 5090 FE Founders Edition GDDR7 Graphics Card
QTY 10
$2000 EACH



Refurbished Grade A Dell Latitude 14 Rugged Extreme (7424) 
Windows 11 Pro - Core I5, 16GB RAM, 512GB
QTY58
$200 EACH

 Refurbished Grade A
Dell Latitude 5430 Intel i7 1255U 1.70GHz 
16GB RAM 256GB SSD 14" Win 11 Pro
QTY63 $139 EA


Refurbished Grade A
HP EliteBook 840 G7 i7-10610U 16GB RAM 512GB
SSD Windows 11 Pro TOUCH Screen
QTY 237 USD 80 each




brand new and original
Brand New ST8000NM017B  $70 EA
Brand New ST20000NM007D   $100 EACH
Brand New ST4000NM000A   $30 EA
Brand New WD80EFPX   $60 EA
 Brand New WD101PURZ    $70 EA


CPU  4416    200pcs/$500

CPU  5418Y    222pcs/$700

8TB 7.2K RPM SATA 6Gbps 512   2500pcs/$80

960GB SSD SATA   600pcs/$30 
serial number MTFDDAK960TDS-1AW1ZABDB


 8TB 7.2K RPM SATA 6Gbps 512 
  2500pcs/$70 each

 
SK Hynix 48GB 2RX8 PC5 56008 REO_1010-XT
PH HMCGY8MG8RB227N AA
QTY 239 $50 EACH


Charles Lawson
Exceptional One PC
3645 Central Ave, Riverside
CA 92506, United States
sales@exceptionalonepc.com
Office: (951)-556-3104


