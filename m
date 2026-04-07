Return-Path: <linux-rdma+bounces-19088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB0AHt8D1WnOzQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 15:17:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC43AEEB4
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589F1302A529
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D753B6C1D;
	Tue,  7 Apr 2026 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="sbSZCogd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-edgeBI195.fraunhofer.de (mail-edgebi195.fraunhofer.de [192.102.163.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3023B3C0A
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.102.163.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567797; cv=none; b=DvH0gFbib6bGRNuBIcJ6BU4rL3FGUCKhDOUDQO/2pFZAojuTtVjr29djrE8Et4h6UcQDyWX178BIgn++0AYqGFJ6h9NDdQs/0eF3p14CVaFyJmT/gNle13qj4j5DcQqxQjLWVIm6J6HxB0KZJmYGrOFd7Vm1VaaJgm1xh/OM1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567797; c=relaxed/simple;
	bh=lgOOqEu5JcyCZ/dUXiwYDEaXayJaYVq6FkB0kX7O4+o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=arjTn2lcx6I84WlB/DZq+V+/g6x9U4g7Wr0uhT+73drrtZvTsl8tJh+uf0KT4moRX3xB8S9yBKiSIb30zOAQ40GEr7b2VDRybxzUsKcakDC1L9iiszLQI4NlV2QKrGsVcR5HZI55M8PjdYAr00ayXI11dwZKxubTfWu2DfSL2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=sbSZCogd; arc=none smtp.client-ip=192.102.163.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1775567785; x=1807103785;
  h=from:to:subject:date:message-id:mime-version;
  bh=lgOOqEu5JcyCZ/dUXiwYDEaXayJaYVq6FkB0kX7O4+o=;
  b=sbSZCogdyxq4dAzV5MxafKbLK178blVIxQgmxkZ64DEAj9ddgLE4F36L
   fS+JL02CG0GMeOq+d0FnI2gifnBNh5wAcH502hnkZl2VtBuZzWUKOoR0V
   rsur0uT6/671eeZRh5/YrcJsIuO57Wadcv09cqxSojoSbn8gBbQlUOl5V
   eJ7kKDVkiSRcUDLvAauZLa5uwU0oqVKHSb5PHYtK7h2o7UjiDo9c168aN
   V6GsVPVpRBGDn4+osRCqFn/PWION+MFKEpbvwgLsQLGgllNZM/F5XoWvM
   DxFGhpbD2Vp5NJ3xyIAb1pujdg7erYnJSc4skGakG+pEaNn5Yqw8WJhp9
   A==;
X-CSE-ConnectionGUID: hibY9HWkROOfS66jRiPj/w==
X-CSE-MsgGUID: 422vFRYkRpChuuMd21vxqw==
Authentication-Results: mail-edgeBI195.fraunhofer.de; dkim=none (message not signed) header.i=none
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2GiBAARA9Vp/9maZsBaglmCQYEHMIE6lkyBFptcgyoIB?=
 =?us-ascii?q?wEBAQEBAQEBAQQEATgZBAEBAwEDhQACjSwnNwYOAQEBBAEBAQEBAgUBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRgEMgluBJwV0MAIBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg00Kk1kAVAvJgEEGwaCdYIdQhQUBrZGgQEzgQHgHBIJAYFDgViGfwGBX?=
 =?us-ascii?q?YMigS+CHIQyQ4EVQnmBN3aDezAaFYN+gi8EgiKBDpATgWYDWSwBVRMXCwcFg?=
 =?us-ascii?q?WYDKi8tbjIdgSM+FzRYGwcFgUuIFYETg3dxAwsbISwFDgItNxQbAwSBNYhfE?=
 =?us-ascii?q?CENgWMZJ4IwOC8URoJ3A6Q7oXkDBAOCNYFnhl2DM4IOlXAXhASBV5IFkwoBm?=
 =?us-ascii?q?QYigjaLMZU0hVkCBAIEBQIQCIF+ggBxgzYJSRkPklSEJcFQeAI7AgcCBw0DC?=
 =?us-ascii?q?5F5I4FLAQE?=
IronPort-PHdr: A9a23:9UOXLxFev0Gs2ALJEcXr751GfyJKhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k20RmRBc6Bs60ew6qO6ua8AjBGuc7A+Fk5M7VyFDY9wf0MmAIhBMPXQWbaF9XNKwEcI
 oFpeWQhwUuGN1NIEt31fVzYry76xzcTHhLiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyK
 wi9oRnMusUMjoZvJKY8xgHVrndUdOha239kKFCNkx3h4su84INv/z5ftv8v+MNMS7n2c7g9Q
 bdFEDkoLmc56dHkuhXEUQaB/GYXXH8MkhpPDQjF7RX6UYn0vyDnqOdz2zSUMNPvQ7wsVjqs9
 6hkRAb2hSkIKjA16G7YhNB+g6JduxKhugdww5XIb4GPNfpxZb3ScNUHTmdcRMlRVihBAoShb
 4sTCucKIOhVo5Xhq1YIsBCzAxSnCuHyxT9SnnL43bM03fk9EQ/I3wIvA90BvW/brNnpKKsfS
 fy5wLXWwTjFcvhY2S396I/Nch05r/2CWLVwcdDKxkYqDw/Ok0mdqYr4MDOPyOsCqXOb4+R9X
 u+okWEnrRx+oiKxycg2kYnFnIEVylfe9Spi24s6P9y4SFVlbtG4CpdQuTuaOJFrQsMkQ2Fov
 yg6xaMcuZKhYScF1o0qyhjCYPOIb4aG+AjsVPqNIThmnnJlfqqyiwix/EWuxeDwS8a53llFo
 CRKltTBqnMA2RLd5MWHRPZw/Vqt1SiR2w3S9O1JIF04mLfVJpM8xrM9l4YevEreEyLwhU74g
 qiWdkA+9eip7eTqeqjpqYGHOI91kA7+NL4imsqhDuQkNAUFQmuV+fyk2bH++UD1Xq9GguAqn
 qXHqpzWOMQWq6GjDwNLz4ou6Q6zAymn3dgEk3QKKU9JdA6dgIXoPlzBO+30Aeu6jlmjnjpmw
 vXLM73nD57QNHbMiq3hcqx460NEzQozys1Q6IxMB7EaJfLzRlfxtNvFDh8lKwC0w/joCNF61
 o4GXGKAGK6ZMKfLvV+N+uIgOe6Ca4ELtTrjNvQo5eTijXEjmVAHYKmp25sXaHe2Hvt4OUWVe
 2fjjckZHWcLuAoxUvDqhUWfXTNXeXq+Rb8w6i0lBI68EIvORo+gjKaf0CumHJBafmVGBUqNE
 XfseYWEQfAMaCeKL8B7lDwLSKKhRJE72hG1rgP6yL1nLvDP9SADr53j1cN16PPPmh0o+zx0F
 d6S03yLT2F0mWMISSE53LplrUNg1FiPybJ4jOBAFdxP+/NJVR83NZrdz+x8FtDzVRvNfs2UR
 1ajWNqrGi8xTt0vzN8UeUp9GMutjgrF3yW0B78ZjbuLBIY78q7E2Xj+PN5yy2za26k5k1kmX
 sxPOHW7iqJn7QjcGZDJnUaDmauycKQTxi/N9GOawWqLoEFXSgtwUbjZUnwBe0fbr8715k3YT
 7C0FLQnNAtBycmMKqRUcN3ll0hJS+n7NNvDYGKxmmKwCA6QyL2DYoXkZXkT0TnbBkQcjg8T+
 GyJNRIiCSq5u2zQFSRgG133b0P36el+pmu2QFctwQ+SYENtz6G1+gYbhfOES/McwLYEuCA5p
 jtsBVizx93YWJK8oF8reKRafMN4+ltC3ErHuAFneJ+tNaZvghgZaQs99xfq1hNqGsBanc0jh
 G0lwRA0Kq+C1l5FMTSC0sajFKfQLzy43xe1Yeqe81fSytuf4e1HvP0+p0/utRrvFU04+V1u0
 sJY2D2S/JzXCgoVX5/rFEo6oUsp74rGazUwstuHnUZnNrO552eqM7MBAeIkzlOtc9hSGoLdR
 VK0HdcTGs6uL+IngR6lY0FMMONT8fsyOMWrP7uD1bWwNelt1DShkSxc4Y97307NvypxQ+LFx
 dAElvef2Abvag==
X-Talos-CUID: 9a23:DEWiZGxeN8FBJlKJdW5NBgUUG8oUI13iz033BEGDVzhrcrytSxiPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AWlZa/QyllntOS6NoCMW7RbSw98CaqPj0Ul4jq6Q?=
 =?us-ascii?q?FgdGvNTFtHjvH1SqnW5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,165,1770591600"; 
   d="p7s'346?scan'346,208,346";a="18499986"
Received: from mail-mtamuc217.fraunhofer.de ([192.102.154.217])
  by mail-edgeBI195.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Apr 2026 15:14:56 +0200
X-CSE-ConnectionGUID: kc5ffPIcSDeZffEV3T8vYg==
X-CSE-MsgGUID: BKclwII6QcKGyChl6FVzHA==
IronPort-SDR: 69d50350_f3m9G6iwdnvnvNznq/8ONbfU7Gt/MRGSjGHyIhUry57zf9/
 9DQD2c2wChm18DIMlOI+rZAC33giKX4tkyIvblA==
X-IPAS-Result: =?us-ascii?q?A0AUBQAaAtVp/3+zYZlagSuBLoFuU0EBRTAxgQmIIwOFL?=
 =?us-ascii?q?Ih5gRabXIErgSUDVw8BAwEBAQEBBAQBNxoEAQGFBwKNKyc2Bw4BAgEBAgEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPAQyGcxUZAQE4EQFQL?=
 =?us-ascii?q?yYBBBsGFIJhgh0HBBIDIhQCAgKpeQGBPQKLIoEBM4EBgg0BCgTbJxiCQQkDB?=
 =?us-ascii?q?gkBgUOBWIImhFkBgV2DIoEvhk5DgRVCeYE3doN7MBoVg36CLwSCIoEOkBOBZ?=
 =?us-ascii?q?gNZLAFVExcLBwWBZgMqLy1uMh2BIz4XNFgbBwWBS4gVgRODd3EDCxshLAUOA?=
 =?us-ascii?q?i03FBsDBIE1iF8QIQ2BfCeCMDgvFEaCdwOkO6F5AwQDgjWBZ4ZdgzOCDpVwF?=
 =?us-ascii?q?4QEk1yTCgGZBiKCNqBlhVkCBAIEBQIQAQEGgW8NKIFZcYM2TwMZD5IhhFjBX?=
 =?us-ascii?q?UUzPQIHAgcNAwuReYFsAQE?=
IronPort-PHdr: A9a23:4c1m3BwRC3gIjYbXCzLFy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9aXSf89hH4cK/8nQfYuKlE2Aa5McyoEKoPfDGMs
 blaGRnqsgRXOiMCrzrQ358V7upR9RmMu0xv3ND+Q4eYBeBwfY/6WNUQanVQcNxQUg5YHpKHc
 rI2NeoFGrZ5hMqijGNTtULiAAynNejw5wJrt0H00LQZ2tZ8KTrUwwtnBfkCmlrf7+7OMZo0Q
 LiW4Y/oyR7kf6tH6TLttaSReC57u+uXTehwK9aM13UTShzc0A+SjJfMFTKx2d4jum+at/BuC
 /3sii1+ui9XhT2twusmupXZhMFF4Q3f1yh/8NsHKojrAF4+YMSjFoNXrT3fLYZtX8c+FmFho
 io0w7wC6tarOSkQz5I/wATDLvGdaY+StxjkWPfZIT5jhDppeb73gRGuuVat0OzyR4GH3ldMp
 y5wwbEk11gI3h3Xr82bQ95A1R34hnCBzQnO7OFDL00u06bWeNYtwb81w5oaq0jNFy7y0AX8i
 6OHPkUt4ejg5+XrKrPhuteCOpV1hBC2AaovnMW7NKVwMgUHU2WBv+Xp/LP59FD/QLJEg+dwl
 a/csZvAIt8cqLL/CAhQurs=
IronPort-Data: A9a23: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
 9OEVfaN
IronPort-HdrOrdr: A9a23:cwc1fqt0oaGmaKlybXFHVqn67skDdtV00zEX/kB9WHVpm6uj5q
 eTdZUgpHvJYVkqN03I9ervBEDiewK4yXcW2/hzAV7KZmCP0wHEQL2Ki7GC/9SKIVydygcy78
 ddWrJwTNnrAxx7gK/BkW+FL+o=
X-Talos-CUID: 9a23:dcsgEm8m59ZL72KvLs+Vv00fR84rSlzW91vdEUG2JFgydO2LeFDFrQ==
X-Talos-MUID: 9a23:5GsPdgRnsDtpyUzZRXTGpzpmK+ZJvZ2lK28cupUC5ee6JwxZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,165,1770591600"; 
   d="p7s'346?scan'346,208,346";a="39168608"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC217.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 15:14:56 +0200
Received: from XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 15:14:55 +0200
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.49) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 15:14:55 +0200
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR5P281MB5216.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:18e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Tue, 7 Apr 2026 13:14:54 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%3]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 13:14:54 +0000
From: "Korb, Andreas" <andreas.korb@aisec.fraunhofer.de>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [BUG] librdmacm: Accessing out-of-bounds memory
Thread-Topic: [BUG] librdmacm: Accessing out-of-bounds memory
Thread-Index: AdzGjkqsA5mJJUzyRWCXQCvGuFkGaw==
Date: Tue, 7 Apr 2026 13:14:45 +0000
Deferred-Delivery: Tue, 7 Apr 2026 12:39:48 +0000
Message-ID: <BE1P281MB24351AAE7EF6E96BFC08D5C9CA5AA@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2435:EE_|FR5P281MB5216:EE_
x-ms-office365-filtering-correlation-id: 997fbb4a-f0cf-4688-a821-08de94a7a8c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|366016|1800799024|376014|4053099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: aBFdWgBaV7MOkRx2+KLFkj5AUM0u3br8lsHu1dqjvbSpKKS5v0cmo1ISnIFviZt8JASj5fiCw+JGNRNecC6urG6m2Uf6gcpozA/tjhOzIhWcs69m4TndkOlSjzD/88s1Rl+CodEK/DOiaM0TLVMYmiaN5QRYOlCOu+HHmSRA7CkAb851rOWr2FLERVjqhtCtoJqsJPzr4/jUrHqcO1ujLKHlAMNWuhL9YS7JR0chwmESz8tG27+F6X5BrSYasSru3gWhll4Q7NLkNn8WEIt8TcdPqwBtnuFupp3NNJ0zTdXrYmd+xRZjMvfnGR3H2aZA5AAxC4jVKEL9Wr3djqjdfV84yiCjkOhJneNIVU0Be/5ypUX4J3V7+lguA1EEQ3qxUrSKW/l6vHS71zUPsKpulEqX7yTFIZRDu3amf3TqNbAMuRIpSKbslL/Rhjx1gUa1KV7aYDxEF/kuF8p8HWwkYUKjGZ29daUIhdepLywP8DvDL7c6BdfqijZRqDn/I4C+XxK18PA+VSxLCNEa3yWLrMHTK3MwEwsrJw8dPlWrS43ZsEeJU+bi3fYIVlBHf4TJmaCmzCGoQLbzvalcz9IO66iUrop9SRxNDQQMKLUSn5KGZWZNsRk28fATMJbGNfj0AufdClGKZW/MlXzVZbC92nV/T/t99Omy+MJWxEwo9lr0p9+wVCozUqME9+WnRo+NHmBw8AgzfjvCQMs/smOrRHx4hdbSfJLQCdvzSmzPGtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(1800799024)(376014)(4053099003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8q7GljjvKvMENSnVhfrr9XDeuYBWZHwpTfxFZLGepUpbDHeNHnsU4CQlnm/U?=
 =?us-ascii?Q?ZNzr7BsYrQwdmZieiSyreRxtaBubOivdVYCtYHwvRRHCimo158gROA1mZnOH?=
 =?us-ascii?Q?1yF3hOATFYUHL9NvOCqVkwC2KmhnY7flTxYftjcVxKXPANaP2DdYh7GvLAZq?=
 =?us-ascii?Q?4OniasbKV57sreb+RRyDtzhKTYpZtDBGzaVkJG47/q8Pm3hgWFQ00IXl0eb9?=
 =?us-ascii?Q?45zmRxMt1stElqQduzVKRUYZXL/zLmnWBYAW6KarA/ee/urzdIP77oJHO+MH?=
 =?us-ascii?Q?YUPSCOQGVuynDdN9Jsl2GBNQFwiK2sQ39R2xjXlv9/bNocQWldmxqtXpsOMz?=
 =?us-ascii?Q?YHu3JtMGQhnwuD239aObbWKa0LeOwmUYLhwZqcMMLQ7HmjsAUblCn/Hx3BtA?=
 =?us-ascii?Q?nnCfvg+rfvGnuGLPvPIqA+BGwvXqNjgDyIsFEwjPEx/X5o60Dc4X4u4+kzp2?=
 =?us-ascii?Q?m/pX3uy/S6ZTmB8X5qFdadRCZDuiMUa66hfOH+KU/BEHqsYUcJhZeBQn47z+?=
 =?us-ascii?Q?fK+i/VOD7Rf6wxSdW/8PyyIkGAnig99ixShARivPbhAeRm3X9pVAjXeCMSoQ?=
 =?us-ascii?Q?ldReKRmr6KhGW1j+tdeTXTA66Mr6g/ZceqR7GOoc2BHeM/Z4z37vkCfppqnB?=
 =?us-ascii?Q?yzNSGaA6s4umZfNGDAMHyLxq/2GhX4gWiXk+zkylK/wtHj6DcFOTGqGddxCp?=
 =?us-ascii?Q?vvjkqkDgAfJ75rRjFo27AzWZv5n3q51DtPIl0b0wEq0HGy1jlCUcjnRUlj43?=
 =?us-ascii?Q?SbVkmP7n1hLSex6Oua+lY5kp5O51h+2ImB3zAG5J7JudISFGNhQ+o+Uhz7HF?=
 =?us-ascii?Q?wR74x6XUphBtKUCHcTWaSlon73VKxjpwdH/CFaMpepEPMbiZ52CVSWIzh2/H?=
 =?us-ascii?Q?RP+fB929wfMkmo+ShtKtBzMqvX5P0U3Bpuy9c0+/qY/QNOnqM8EPRjGHmPLE?=
 =?us-ascii?Q?Zxn5lHEsGCmFqh/Dt6IMmOvVwcWLrlLln3P04/RxL7e121ggpdbvzr0/i4Rb?=
 =?us-ascii?Q?ERfY1lmSHjMCyLy/MiGpHEDZU0dG50Abp2Rb2xpjia0bgeHN/cSal6IGlBpR?=
 =?us-ascii?Q?MVPPXbv79HaQsmkJEH1RzmUTpdKCJbGOa/iiKtmkzUtiyZXXRHRefhzuz6hO?=
 =?us-ascii?Q?Fvf7T2b7fFmpsTEZJXoOAWahFTu93v23qrzPhbNDbmhQnOyeaMdZ+6wvOgNI?=
 =?us-ascii?Q?r7FIqGL3C4Rttb1n4Jd26zdUHVaJM6EDrz44Ag8ZUCeXyBu6o5Q0kA7p1MFc?=
 =?us-ascii?Q?l9HO/juKdVJzY5oG9VJLanN19HnwqNVw7dd0T+SDkrGBPJ29eoLjUfeuR9/P?=
 =?us-ascii?Q?ZGw3v0F47ODHrRKe0yRxqmRaw40xjewhZjUg9tFN1ihM3cDIBRQYBrXdZGhZ?=
 =?us-ascii?Q?XqdzAwkvVz6ftyymGqICo5bhhBvDnV3wfy64btlWesPwBr0XYosaXCmWGduy?=
 =?us-ascii?Q?yKRHCjOUwv3nNG1P/sGBO7Bh2iAtv4pH5RUMOylt36h4eg+kXKGYO81iwPKU?=
 =?us-ascii?Q?GFmU4jn09wgct0MHfgL3y6zKGyfyUS+FQ5wxqyoSVYMynfe1jjq1jvaJ42+b?=
 =?us-ascii?Q?63ukTP9NgOI6l/phIBFF7q2VPGaXHqvfJR+cupqIEffu+dVLNomArF6nsCY2?=
 =?us-ascii?Q?y+pU/YUITs/0scoFs65i67yN5K5/7eF2RyitlqS2KhUVOPGe/GfWIWIfaIBI?=
 =?us-ascii?Q?HL58utD8I7Ec40KKkXsZug56sbL/KeMeOjqCbr+OgLOwOlQ0GgqVUE/FCgZs?=
 =?us-ascii?Q?y/f1MMOzT3aZ8A0NPqxeJ18O8ut7o/8=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0050_01DCC6A0.FF60C030"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TMkDyTJL6lH83AeEHYUK7KQcCM6ovpmxnlS59gPMwO05cTCbcLKmBn7Xv7tWgQUORHIjc+/+kWuwX6ycOH0C4iX74yycvtpxNb9pbhgPO4Wl2+JSRIrG+qrbIs1et2Z9a+4D4HFJda4cumGJ0XwmzS1KHLvkJIAwWGUJOT69udInAs1yl6KHd1jWlb3Rsvqs3fqGLCdW17USlej7FoaDMNYqVaPwXR0f6MStFYeSr0MKs5hS8MEtGX+l3OUd7ekgoZO8TD9EdDdkdLBuKVvtB5fNJkyA4viOaT2P0fwMso4Fk22juCNTke59STiexDiA4cO33yEJlTh8E4vRWMCk/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 997fbb4a-f0cf-4688-a821-08de94a7a8c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:14:54.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUy62/V6TfKCfYAST8LOAoemDKtN6RJMP7A3LETjcOIUdut4MihZ8iE2XHKOvayRPATZSNmP2Uho64N1yaksgwAgJiGiDbBMQ40jZHzNBnFh3B70wIsxWisymyQodRZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5216
X-OriginatorOrg: aisec.fraunhofer.de
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aisec.fraunhofer.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[aisec.fraunhofer.de:s=emailbd1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aisec.fraunhofer.de:dkim,BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM:mid];
	DKIM_TRACE(0.00)[aisec.fraunhofer.de:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-19088-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas.korb@aisec.fraunhofer.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C9AC43AEEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------=_NextPart_000_0050_01DCC6A0.FF60C030
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

The function `ds_init_ep` in librdmacm/rsocket.c may access memory via an object that is not allocated for this object.

Relevant lines from this function:

// (1): Prepare `struct rsocket` 
ds_set_qp_size(rs);
// (2): Allocation
rs->sbuf = calloc(rs->sq_size, RS_SNDLOWAT);
// (3): Copy pointer to rs->smsg_free
rs->smsg_free = (struct ds_smsg *) rs->sbuf;
// (4): Copy pointer to msg
msg = rs->smsg_free;
// (5): Write to msg->next
msg->next = NULL;

Within my podman container:
Before (1): rs->sq_size = rs->rq_size = 384
After (1): rs->sq_size = rs->rq_size = 0
Therefore, (2) does not reserve a buffer, but still returns a pointer which can be freed later, as described by man-page calloc(3p).
(5) writes data to the buffer allocated in (2). If no actual buffer is allocated, it overwrites arbitrary data, yielding undefined
behavior.

I found it by executing /usr/bin/udpong (without any arguments) with libscudo on an arm64 server with memory tagging enabled. It
immediately crashes with a segmentation fault, then. Without memory tagging, the bug stays undetected, and execution continues.
The code behavior described above also happens on x86-64, there it doesn't result in a crash and is silently ignored because of the
lack of MemoryTagging. Valgrind also detects this violation, however.

In summary:
The libc man-page states that if the allocated buffer size is 0, then either:
>        *  A null pointer shall be returned and errno may be set to an
>        implementation-defined value, or
>        *  A pointer to the allocated space shall be returned. The
>        application shall ensure that the pointer is not used to
>        access an object.

and the function `ds_init_ep` misses to ensure to work for the second case.

* Linux distribution and version
Debian Trixie (in podman container) 

* Linux kernel and version
Linux arm01 6.12.22+bpo-arm64 #1 SMP Debian 6.12.22-1~bpo12+1 (2025-04-25) aarch64 GNU/Linux

* InfiniBand hardware and firmware version
None available in podman container

* How to reproduce
As I'm assuming most people use x86_64 machines, this shows the bug with valrind:
podman run --rm -e DEBUGINFOD_URLS="https://debuginfod.debian.net" debian:trixie bash -lc 'apt-get update && apt-get install -y
valgrind rdmacm-utils debuginfod && valgrind /usr/bin/udpong' 


------=_NextPart_000_0050_01DCC6A0.FF60C030
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCG1sw
ggYEMIID7KADAgECAgEBMA0GCSqGSIb3DQEBCwUAMIGSMQswCQYDVQQGEwJERTFFMEMGA1UECgw8
VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUu
IFYuMRAwDgYDVQQLDAdERk4tUEtJMSowKAYDVQQDDCFERk4tVmVyZWluIENvbW11bml0eSBSb290
IENBIDIwMjIwHhcNMjIwMTI2MTQwODQxWhcNNDIwMTIxMTQwODQxWjCBkjELMAkGA1UEBhMCREUx
RTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5n
c25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTEqMCgGA1UEAwwhREZOLVZlcmVpbiBDb21t
dW5pdHkgUm9vdCBDQSAyMDIyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwXl1XiM9
1IJfy5XmHdP0edJDN+hIrt3DQXvGprxG8z2ypPyV78KuuAcrH3oNe1gsKKpe1EjLs+3/mh4/MnQr
pSSa8WmhbQWDkzEMooITuu9ZK+T1Tyrc4FiTL5flvPn46N0tAXos8Fw18EOst074MzvX8Xa4NcOP
B3RcIIAxMYPPZzAZu0XjjsyxZ0NS7dV0/1gxJjBYGL4+PaquJzpfwnqztdMpMGdLFI26UAe06VSN
Jj0+DL9haSf3kFSkxP+NV94ptCtYKkKm18bsp5ozTwPXVWFpEh9T8tUMJB5/nup2QoOHaIHAJa8R
dAyoyfXy48aCHnRcK4N2XISgoCXFZzvhRDrXlDaJouCG8oKdirnDMU5oi73/MvJ8pREAsTZzsc1j
ROjoJ6NstEoJYXcqSvqpnLcS2ZxjGsWkQgGon1BgUNfiTyGTsoipHb+9hQVLllfUYsGkKpp/9iQc
BRqPWKqphzz+XlIdeq7CCZArXOGkHzPC5vDmolYWRkY7Qd4TEqUmixJFaEyDjvWZ69hWblaMgxsX
s+XqNd5fJ8ZO7BtmPsPcIKQ3KvnaK+LBBYc2zUpX1g60TXUfXtH8fh1Ze3U65UQeQFTHhWN17dXe
sDkyK9sMv9hekh+UEgEzO5eFvNiuKXjOg+eRUo429bYkBFbFSdYUnj3qOuhh4aDjZN8CAwEAAaNj
MGEwHQYDVR0OBBYEFBD2r6P69haQ0OohQRKXEfibpVqUMB8GA1UdIwQYMBaAFBD2r6P69haQ0Ooh
QRKXEfibpVqUMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUA
A4ICAQBL6dBAYICSDUumGRJNk7z3Lmzg5E0CNzoL0HXaXdski/MldmVoPONcMYOB39uNeszAimvF
Gj8tlJKvBZwdr4c9v5FMQpHPIjg0tTBolS9PLEDfbQ66Bl/7HyqXKPYcd5fjoz+zqhzGtTw5f5CN
/ViGSBlAf1/IxKoK5wP8GxisMII8BODyJTb9VpEcnnLggITMCPEUPJOKgp5Kd5N+FyJgxrUI4vyi
QRfRPSR4bH6E70gvtRigN2pAamxExDO/06ByAm8/wJKpqUT/Mbzh5TXVrCfFAcHtvPsdXd5NWfI2
DRN0VT5Iy62JZrzQp/TTpqPlDU1/3iSY6M3nJd7t9SeIxJzBoS/vihmFxY8mEiMtsN3AiYEcHqAj
lzW3i4QZmPijQ6vLNUoYl4DUG/J8XavJE4bZ4k3jmYSDaYhUvDLo4j/d8rEGwbMujP/tiudNJzhb
lS0zfgtkBktW5rdutMMe7aKJqmJcWIQ7z3FPybWZxAnAFgfdzuPo5TBN8cp7USkKgk0yF1G7LsdI
M7f2AoojTjL+lr+rMGPZ/QWVdvMPXSe/y7eEGivGgSGoDe1iLcVBDA+6jqbuo5eR88PXc9FRj39G
/+ySlFhwwn/uNlCToJhHtOX2L+KldPkHTWPwdAR6O/gHWKv8KoLXnpDB5VsNsnQq/Ws8JYKBSKSM
z+G5RTCCBsUwggStoAMCAQICDCpUFPrFzZpu4PHntDANBgkqhkiG9w0BAQsFADBnMQswCQYDVQQG
EwJERTETMBEGA1UECgwKRnJhdW5ob2ZlcjEhMB8GA1UECwwYRnJhdW5ob2ZlciBDb3Jwb3JhdGUg
UEtJMSAwHgYDVQQDDBdGcmF1bmhvZmVyIFVzZXIgQ0EgMjAyMjAeFw0yNDA1MDMwNzUxMDdaFw0y
OTA1MDIwNzUxMDdaMHsxCzAJBgNVBAYTAkRFMRMwEQYDVQQKDApGcmF1bmhvZmVyMQ4wDAYDVQQL
DAVBSVNFQzEPMA0GA1UECwwGUGVvcGxlMQ0wCwYDVQQEDARLb3JiMRAwDgYDVQQqDAdBbmRyZWFz
MRUwEwYDVQQDDAxBbmRyZWFzIEtvcmIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCT
hwRMY6T3FTahs02+WycNSNPD6RAf1pBmaD3VZcPci6VRFcgnGgqVB1vIG9CKohqY6DpOjMznEth0
uQWZB8a6HR1ZV9CiGpor2LsNc7V94u8IiV11qdiSzkCV0/mG1cKZIWAfqA5kRXsVsU7GODyE75wT
4H6bV1dzDznhgAINFqNfgAPgNkEv5QqqCG7uscmSLKIQ0CtmMvZqI1QxaU73oX2hRBk/oEPRqUKH
k4R/xSLxc8AfJOzi3FJw6FIrlk0Ie5NhHcu6hohogMKZg5A7cFopUHVgzLFvazDnj6Qp+YfXym5a
+nWogy3JysTVFmUSU8JcAJ3MRAV0F1GS1BRpAgMBAAGjggJbMIICVzAJBgNVHRMEAjAAMA4GA1Ud
DwEB/wQEAwIGwDATBgNVHSUEDDAKBggrBgEFBQcDBDAdBgNVHQ4EFgQUKFdt018mXQBw3rpXi1pl
Ak3y5W4wHwYDVR0jBBgwFoAUE2O0My6cEnnf+fGWyKjUD3vZ3/4wKwYDVR0RBCQwIoEgYW5kcmVh
cy5rb3JiQGFpc2VjLmZyYXVuaG9mZXIuZGUwgaUGA1UdHwSBnTCBmjBLoEmgR4ZFaHR0cDovL2Nk
cDEucGNhLmRmbi5kZS9mcmF1bmhvZmVyLXVzZXItY29tbXVuaXR5LWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMEugSaBHhkVodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2ZyYXVuaG9mZXItdXNlci1jb21tdW5p
dHktY2EvcHViL2NybC9jYWNybC5jcmwwgfMGCCsGAQUFBwEBBIHmMIHjMDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwVQYIKwYBBQUHMAKGSWh0dHA6
Ly9jZHAxLnBjYS5kZm4uZGUvZnJhdW5ob2Zlci11c2VyLWNvbW11bml0eS1jYS9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZnJhdW5ob2Zl
ci11c2VyLWNvbW11bml0eS1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwGgYDVR0gBBMwETAPBg0r
BgEEAYGtIYIsAgEHMA0GCSqGSIb3DQEBCwUAA4ICAQA53DKSgu6sRT2uY9G/+RVgzuQtPYOsNa/n
y/tiVeb0y+ZhKIWVAwA1mI9Ykb8BPFgpJR8s38OXkbb86861sU6Fji9MR05FVTCkhEJLIyRzOgy5
KbeyA27j6TLf/+V/tcmFl5rout6PHILenljI1RVjE16HTl4jL0aYO1bSpGkb466twy2d6+/vw+5T
4DAp5xtaO1YVXR7Ocp8SZXO/odfL6T8EDn7k6v76hiemrwfb7tO7ENNX1fkVLAI5rbz2EBSkN7RY
e9vso+pSIyLSPl8yMVCdYeYs5Vul8s1B2uXuJIowyF6Onked3f3LiFThCDPVvHGBSJ2BzPZRV9Td
Ah1hIcyZZa/e/0PHiq63sHe2Ixu2KnIBlIW6f/OWsreVPypBxCW0XzMExohzhIiLnUAjER6JBK71
e96pKt86bXQTLG/rjIqU+PJG0oJBIUULzbqBifGYIG3qoFSmczib24il8+bABhv4HMZ8lmwv+VeZ
hMpajeWk1IwHjrWXoW8P+/X5JXdyCQNOCieahprPSbaq8FGdB2rdR66czctOL+gO9BXCprWu6szk
A+37bICNgruyQXoDdEIWqojyL7RtS2NR64HjPr/aIAGDSm7wGyQOAtqWYWpDhJQMpoA170HbUYv3
Eg34VheJ10naHZ0ynRNlYQrCepj2gfADs/PIFCpbvTCCBt4wggTGoAMCAQICDCpUFXKFvadQ6NZo
KzANBgkqhkiG9w0BAQsFADBnMQswCQYDVQQGEwJERTETMBEGA1UECgwKRnJhdW5ob2ZlcjEhMB8G
A1UECwwYRnJhdW5ob2ZlciBDb3Jwb3JhdGUgUEtJMSAwHgYDVQQDDBdGcmF1bmhvZmVyIFVzZXIg
Q0EgMjAyMjAeFw0yNDA1MDMwNzUzMDZaFw0yOTA1MDIwNzUzMDZaMHsxCzAJBgNVBAYTAkRFMRMw
EQYDVQQKDApGcmF1bmhvZmVyMQ4wDAYDVQQLDAVBSVNFQzEPMA0GA1UECwwGUGVvcGxlMQ0wCwYD
VQQEDARLb3JiMRAwDgYDVQQqDAdBbmRyZWFzMRUwEwYDVQQDDAxBbmRyZWFzIEtvcmIwggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCKfVyX7C8yLfG8xBUcsz8jR4XgtWTvisM0RODqsSbd
LJ4hHhY3S0rgip2qL7FOKiTxBHeifiEFdtYDNG81qWsKWZdq5VRRitIxSs9ne4WfsrfEfEkEEXt6
wjCmw9YfehWSgw7Iywgle6YqBm9TDMWYP7T+CAkqm54qaG4ntvJk6UgvpyNZ12y7Y0MCVSkhkIZM
zBG96vdS5Ydhdfi0iNvdadxX9MRkVXzF4WQ/RCV/kPnvE4cwcY1mw3D6Xv6C3xye8hdL0IrqkYb0
hIZzZfz4XoTdzsIc2g1h2PesWCPznjqO2G1KjdvyNtxJCFtZbTh6U6bZR5wydHqpT5UA1o5zAgMB
AAGjggJ0MIICcDAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIFIDAsBgNVHSUEJTAjBggrBgEFBQcD
BAYKKwYBBAGCNwoDBAYLKwYBBAGCNwoDBAEwHQYDVR0OBBYEFALOgIWZ1hO+FClgRJUsGNUU3yue
MB8GA1UdIwQYMBaAFBNjtDMunBJ53/nxlsio1A972d/+MCsGA1UdEQQkMCKBIGFuZHJlYXMua29y
YkBhaXNlYy5mcmF1bmhvZmVyLmRlMIGlBgNVHR8EgZ0wgZowS6BJoEeGRWh0dHA6Ly9jZHAxLnBj
YS5kZm4uZGUvZnJhdW5ob2Zlci11c2VyLWNvbW11bml0eS1jYS9wdWIvY3JsL2NhY3JsLmNybDBL
oEmgR4ZFaHR0cDovL2NkcDIucGNhLmRmbi5kZS9mcmF1bmhvZmVyLXVzZXItY29tbXVuaXR5LWNh
L3B1Yi9jcmwvY2FjcmwuY3JsMIHzBggrBgEFBQcBAQSB5jCB4zAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMFUGCCsGAQUFBzAChklodHRwOi8vY2Rw
MS5wY2EuZGZuLmRlL2ZyYXVuaG9mZXItdXNlci1jb21tdW5pdHktY2EvcHViL2NhY2VydC9jYWNl
cnQuY3J0MFUGCCsGAQUFBzAChklodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2ZyYXVuaG9mZXItdXNl
ci1jb21tdW5pdHktY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MBoGA1UdIAQTMBEwDwYNKwYBBAGB
rSGCLAIBBzANBgkqhkiG9w0BAQsFAAOCAgEAdj28D3r2p6SvDnDvkzYAStGQvzJgM75DfdZvYNaq
m9oQwWwnNyqP1ZzrxjhkcT/aw0DAmE8EYP64gxe4VkVtXSY9652KcKf/LJgP/6iruqwv3BejOhFO
e6rSBJOZXwefkLg8RB8du1GPXMwpj5lcQqLfFa6QDLwwDImS7hhCK2OZMy26r2gdzB23uyRfQqe3
i9Apxi2aRa4Pih/Cx1c+gyJ6uTFEKjrVknwQdz4Mm+i9UrRoDq0XwXTy/kPCBJP6Of5c5ojIuehv
9bxwdTsbsZH+LYkgcW9xWnHSFBabO7mkBtlC9Cn4QvrcifqAtSaymp1s0qLbvSEmj6UEcSsSSGxE
sEwdZy1L82CUrNmL12KB29O8Uinz/NQBnbLSaTFdddCAP2jubK1caocreEYc8m/qQOFWbzx2rXQ8
GQpowbiBVuX/0AIYcbMhL5iS39llC1jCtxsQHhaNYKitOu+Or53L4cbuUwMmeT2K+61gELZikdr4
VbH7c51AtHBx9Io/ROt1hkp2+P5S+7NXWbJG+AGFtC11+OrFyM2qtBIvgi8F/wkIfZcxYpMLmuOA
Cm1Cl4kr+AgHDqxq8V09uZOF2dnZZ0k9n60zVb8y1/71BTs2f/Gca2NDDzOX4mXEYeoW7zfjb14S
vfavwbBKTM02uzkzPyoCHuA6xsCwK42LOcQwggekMIIFjKADAgECAgwmsBq5CU9B28zfPWMwDQYJ
KoZIhvcNAQELBQAwgZIxCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1
bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1Q
S0kxKjAoBgNVBAMMIURGTi1WZXJlaW4gQ29tbXVuaXR5IFJvb3QgQ0EgMjAyMjAeFw0yMjA1Mjcw
OTQzMDVaFw00MjAxMjExNDA4NDFaMGcxCzAJBgNVBAYTAkRFMRMwEQYDVQQKDApGcmF1bmhvZmVy
MSEwHwYDVQQLDBhGcmF1bmhvZmVyIENvcnBvcmF0ZSBQS0kxIDAeBgNVBAMMF0ZyYXVuaG9mZXIg
VXNlciBDQSAyMDIyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtqaTG2zRanXot7uU
tkqfAkoCS3cx8q0/gMg5YFxhToQJw9oPt4ePb3ZpCG3rILQhAPM6eUweb0POXgsmF4a9Da/Wjm/d
a0/68i7tvSY4R+Ajp2NzhZhjDl5O6hgoP35d8Rdq+9dZNi9MN2bBcFFcvWJZW/IZf3AZAyJ+shsH
BLEqBJB/Xq3+c5SCB5ER8NZMDCSRx3a3kgAhoJWcS+5SanS4bsjbhfCxvYhUJtErxdR040aa0Akl
/J3WkyzgGeIzb86utriONBMZR/PAGwMk8hzlqmGh5E7Kt1uIzXUcgdmrTLRodczTkeD3RDXoYpbJ
P1Labl8gQd09LrY7IVg2H+pPFECNlBdlWOZe4ssddAYnRUjCh8WITFp8hmN79i0HPvQwUPN97rZ4
uQuNajrO0bQlm2JsIRtEz4W/zNQ3ctI2W62YJprUAAaaU0+kMdUtBQCUDRr3xa6QCIA3q4Rj3wBs
1+rtaYNyuykhqis5h7iM4Omcm5YX4cCA6ZyLN/HUxOnnDvWTYVQcpdNFqzk07TsRYVVCBf7vDj/a
roQfnnJYujGrR9boCewArrFFQGOisHwxudgF6CENjGgVVv6beAy/8xcsisA1aiCPmXUpzK5bj1rL
wa33micTHBg/MsMoEAG38yakEPdLCEQa5PCRVCl8Q2t12t6kE1+edX+CjJECAwEAAaOCAiIwggIe
MBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0PAQH/BAQDAgEGMBoGA1UdIAQTMBEwDwYNKwYBBAGB
rSGCLAIBBzAdBgNVHQ4EFgQUE2O0My6cEnnf+fGWyKjUD3vZ3/4wHwYDVR0jBBgwFoAUEPavo/r2
FpDQ6iFBEpcR+JulWpQwgaUGA1UdHwSBnTCBmjBLoEmgR4ZFaHR0cDovL2NkcDEucGNhLmRmbi5k
ZS9kZm4tdmVyZWluLWNvbW11bml0eS1yb290LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMEugSaBHhkVo
dHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi12ZXJlaW4tY29tbXVuaXR5LXJvb3QtY2EvcHViL2Ny
bC9jYWNybC5jcmwwgfMGCCsGAQUFBwEBBIHmMIHjMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5w
Y2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jZHAxLnBjYS5k
Zm4uZGUvZGZuLXZlcmVpbi1jb21tdW5pdHktcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
VQYIKwYBBQUHMAKGSWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLXZlcmVpbi1jb21tdW5pdHkt
cm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggIBALRwdrYjlbo4
Je5O1PUhz1E/XQi2g+/UglPNndY20XOAqeeJLIion6lP51ZRO+5lheKrmGJcbwvFeDsnLxw5qfyo
887tFMF+rtxf/Ft0uAorG/bKJRAep7DWGBmJWHscw53I7bTcQzeR/owF0XmrDpHzko6FGUyPD0rD
yOZK20Ha9GibkGoBgDGkpekLOLpHE5BMyPxU5ul1DvqMtlbWlUX2FNBzbTLwUSHDUlxdcocikyhm
PoCINiGCSIFthYTxkkErEA+E6g3qIikkAyAfbwcIM6X6DmIpt2u1irP2ZxuHrOJgc2UIPl8c6B9/
4RDzgqZ2VnkmyGkXtNhropcBo8LemQ4+C+f5Hx78hhsxUNUkIti1Fv057RtQkVjmi5hftH7ppNuL
F7GLEEp5L4+RbbjI3BWJ4fQrUjl72QzrNHo16sRuuUo/K7VwsV793u0c3moDC9t/xgxEnHGYl7rI
1rU1GoUbM7L5g/ddC7F2cXu9LneOy94gc8H2515rCLJMAFRQMihBXs/EbW4YJOqbz52jzKssANgo
S6rKweF1zFFMsCW/B6U9SV2wMriCq33QdK3F8ZQ2e4wtrNuAyTYPYw9E8GQUm3GSBIAYP7zTLipl
5pFUmxwor1rMQBr+Y6cI5ANfIPk0YNs3yVactIiYRdPpNfYP9M8IipGXlBeWvWuSMYIDuTCCA7UC
AQEwdzBnMQswCQYDVQQGEwJERTETMBEGA1UECgwKRnJhdW5ob2ZlcjEhMB8GA1UECwwYRnJhdW5o
b2ZlciBDb3Jwb3JhdGUgUEtJMSAwHgYDVQQDDBdGcmF1bmhvZmVyIFVzZXIgQ0EgMjAyMgIMKlQU
+sXNmm7g8ee0MA0GCWCGSAFlAwQCAQUAoIICEzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MDcxMzEyNDlaMC8GCSqGSIb3DQEJBDEiBCBKIE56RFMGDGiiW7F3
TlI2QpWk++9PBNDvLhmmuXHgFjCBhgYJKwYBBAGCNxAEMXkwdzBnMQswCQYDVQQGEwJERTETMBEG
A1UECgwKRnJhdW5ob2ZlcjEhMB8GA1UECwwYRnJhdW5ob2ZlciBDb3Jwb3JhdGUgUEtJMSAwHgYD
VQQDDBdGcmF1bmhvZmVyIFVzZXIgQ0EgMjAyMgIMKlQVcoW9p1Do1mgrMIGIBgsqhkiG9w0BCRAC
CzF5oHcwZzELMAkGA1UEBhMCREUxEzARBgNVBAoMCkZyYXVuaG9mZXIxITAfBgNVBAsMGEZyYXVu
aG9mZXIgQ29ycG9yYXRlIFBLSTEgMB4GA1UEAwwXRnJhdW5ob2ZlciBVc2VyIENBIDIwMjICDCpU
FXKFvadQ6NZoKzCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYw
CgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAL
BglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjAHBgUrDgMCGjANBgkqhkiG9w0B
AQEFAASCAQBLCBKApbu5vmVF/+gW14ZxT4wbDN3t0J3OmD4qDsw/oAAMPavcK7A3PY+4bzcY1QG+
1r+tVf8pJ6ulTkBd0vFc38BoxPRaa3zxMz506Ujm3MlEi0ehNXVXhaH2RFmH4HL7jOuzTaA1eQ43
VYjG7K243EgppEcKEikhkg4wx4sU8Hm8DtUn++U3DjX6GS0jCsUSe/shMbTgVasv8QNUVfOzmUAp
xYGdtWDYTvNKU9nbns9nZQqzUR0PpDZy4D9mZkul83kfn3fVntjvqRbWVDGS3eX3YzmgqtE59MR8
PLfusMFoO1CwrusG10SmomAg9lyJVHAgWWmBRd9fZXKjm9MRAAAAAAAA

------=_NextPart_000_0050_01DCC6A0.FF60C030--

