Return-Path: <linux-rdma+bounces-8441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DEA55A82
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D42165860
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD627CB1E;
	Thu,  6 Mar 2025 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="Jyeh2Q0l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5972E3373
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302240; cv=none; b=NT8U2CHGWN75H1g9J+7KlntNyi4exJrrp+VttnTc756XV7ukeViOTGrT9h6MWs2VLBe7bVOddk0LD+PEzJH1eN9n5PW3n/B5pzxj3A96zpuGwh2OLdw0RRHQ6EHB3n560ZrIdhZCjXaEVksaIcEc+2Yh0k8diHH/6Cl71K+yzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302240; c=relaxed/simple;
	bh=9P5cR3wVGceuqqoN5Lm0uHgjh9VXikU5XM/VGHCnUDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPnXCFlf51yUlmHeRzYxrbqOjwq1BULS5i/xec2HLEjOXHfXOS44tHuq5YZhZLXS5UaN4tBIIqJRNIPSOStE/8WZ4mU42bSMyBY/sTub6/NDRDel5HR1DKf7ExbTEglgsSkjvREPCS04yOpvXjzOYNB8M9ZuVOGS/IKnvSjXQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=Jyeh2Q0l; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3cf3afc2bso137655885a.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302237; x=1741907037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5InOh2hFVrqxOK4OiWxKFEK8Qv8GjpqOw6YDveGcgX4=;
        b=Jyeh2Q0lw4XDicKEzBiUEOwTgRzL47m0qnfOvXwtL77qio/+saDvQ6/nqEygrIyxzn
         ItE0FGMg6X5lsj+Tf+5BnnNfsun0/Dgn1P/Oss2rqpE7SSYPN2X2WD5FSiciTLTjloh2
         wNS06+XYWJr7yVyyNgRQA8F7ZWGyQ3SDczKBtJhYm5cmXAXIK+rpgmkxs7K+0LajYQuC
         KA06QcoAJnGH5ylfhHhcyX3cZG8oMGO8puhynGUfN0jTiCWV+KbcW9j3uN4yUeH5po1d
         oahhybg7Z6FvuWOUXjdVNn3qixVcxtfE6crjoQ4slCrncbRsf69EHQM9JQs+AbfcSd/R
         Qh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302237; x=1741907037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5InOh2hFVrqxOK4OiWxKFEK8Qv8GjpqOw6YDveGcgX4=;
        b=JyS4nKgKy/SU3C2VUEXhCz7xuVAfbIWIqc/TS9OSkGTJyZzjcpsG4I8aRD0vMj4uo4
         M6PA7fVNV8Ob3mIG8OuqNOIrwl3VE5aW9o9Hv2XoTkOEwX5dygy0zzg7d0izkwiPnh4J
         28ULMXEw2JGAPeDwHqXpxqT/xrEqvxaYGzoadk6M0mBF0T/rcuvfQQgr+RdAEP8IvsBD
         4G5T0zVZ6AKgzRbl4W3GLpTUruLFuPIHgQYtUwFCLtuZp3hZISBtJyp9nnDXK8hYxqZw
         3mQsFhMDCj/aX6bx8rOiVDm1V4jW4OetzfBN/pkuB28Enip3ZjMtHOgSMJP/pcpRXDua
         0Jeg==
X-Forwarded-Encrypted: i=1; AJvYcCXcbj1R5+NxOupXdUt9i5R2vcysuGBD/mcAi3k3DAMERfyOa/9Sv0RB9elpX56IzPzUfWf12gtlsuRz@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQX9QZE48rxPMujBuugxxuD+KZIgpv3NILZHeA1uXeL3l5L29
	RHJV9NImyGxKJxrwXB18EdiJzdHxj/7n7cOXGzAFI6QVvBsawUGLdM2P03216DY=
X-Gm-Gg: ASbGncsQWEdjoRZzC0Lf4uMk3weSR0xz9VFSqSl9jBfjb/I9L8+u5EmWOYuEBSZAnXL
	EwXUgu3z6alK2maGeGki2CXZGWPVpJvSYy2eFsjX41Kwi7w+IVCmWY26sxkr/zi4iEcApWsigkj
	45HF4wb/dEtMMMIFSf/Bop53zFR+PZODWDDBBBOrISVA0JqUMYorFBntgN7HmJHauNmXvkALh9a
	W56GLLlFD5GGXLPw029TMjCuP8iBV39JMJJd15ZBjmpnsTqn5bTDP4DEVyLiYexP9zlx5DX52OM
	RhrNqwpEKR8MxPH3j627F8SeQJ9puFr4aTFQxaf3j75oygdRUogh65hst1Q4Rc2EjmG2
X-Google-Smtp-Source: AGHT+IE0VCegJ5qUOHQr9rsnIZKUaDSaW8i/nzICrIQVmh8UnzI3rC2bisxKwRROzU5eyrR4TJ3QlA==
X-Received: by 2002:a05:6214:21a6:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6e90068196dmr15445456d6.38.1741302237271;
        Thu, 06 Mar 2025 15:03:57 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:03:56 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Date: Fri,  7 Mar 2025 01:01:50 +0200
Message-ID: <20250306230203.1550314-1-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
This patch-set introduces minimal Ultra Ethernet driver infrastructure and
the lowest Ultra Ethernet sublayer - the Packet Delivery Sublayer (PDS),
which underpins the entire communication model of the Ultra Ethernet
Transport[1] (UET). Ultra Ethernet is a new RDMA transport designed for
efficient AI and HPC communication. The specifications are still being
ironed out and first public versions should be available soon. As there
isn't any UET hardware available yet, we introduce a software device model
which implements the lowest sublayer of the spec - PDS. The code is still
in early stages and experimental, aiming to start a discussion on the
kernel implementation and to show how we plan to organize it.

The PDS is responsible for establishing dynamic connections between Fabric
Endpoints (FEPs) called Packet Delivery Contexts (PDCs), packet
reliability, ordering, duplicate elimination and congestion management.
The PDS packet ordering is defined by a mode which can be one of:
 - Reliable, Ordered Delivery (ROD)
 - Reliable, Unordered Delivery (RUD)
 - Reliable, Unordered Delivery for Idempotent Operations (RUDI)
 - Unreliable, Unordered Delivery (UUD)

This set implements RUD mode of communication with Packet Sequence
Number (PSN) tracking, retransmits, idle timeouts, coalescing and selective
ACKs. It adds support for generating and processing Request, ACK, NACK and
Control packet types. Communication is done over UDP, so all Ultra Ethernet
headers are on top of UDP packets. Packets are tracked by Packet Sequence
Numbers (PSNs) uniquely assigned within a PDC, the PSN window sizes are
currently static.

In this RFC all of the code is under a single kernel module in
drivers/ultraeth/ and guarded by a new kconfig option CONFIG_ULTRAETH. The
plan is to have that split into core Ultra Ethernet module (ultraeth.ko)
which is responsible for managing the UET contexts, jobs and all other
common/generic UET configuration, and the software UET device model
(uecon.ko) which implements the UET protocols for communication in software
(e.g. the PDS will be a part of uecon) and is represented by a UDP tunnel
network device. Note that there are critical missing pieces that will be
present when we send the first version such as:
 - Ultra Ethernet specs will be publicly available
 - missing UET sublayers critical for communication
 - more complete user API
 - kernel UET device API
 - memory management
 - IPv6

The last patch is a hack which adds a custom character device used to test
communication and basic PDS functionality, for the first version of this set
we would rather extend and re-use some of the Infiniband infrastructure.

This set will also be used to better illustrate the UET code and concepts
for the "Networking For AI BoF"[2] at the upcoming Netdev 0x19 conference
in Zagreb, Croatia.

Thank you,
 Nik

[1] https://ultraethernet.org/
[2] https://netdevconf.info/0x19/sessions/bof/networking-for-ai-bof.html


Alex Badea (1):
  HACK: drivers: ultraeth: add char device

Nikolay Aleksandrov (12):
  drivers: ultraeth: add initial skeleton and kconfig option
  drivers: ultraeth: add context support
  drivers: ultraeth: add new genl family
  drivers: ultraeth: add job support
  drivers: ultraeth: add tunnel udp device support
  drivers: ultraeth: add initial PDS infrastructure
  drivers: ultraeth: add request and ack receive support
  drivers: ultraeth: add request transmit support
  drivers: ultraeth: add support for coalescing ack
  drivers: ultraeth: add sack support
  drivers: ultraeth: add nack support
  drivers: ultraeth: add initiator and target idle timeout support

 Documentation/netlink/specs/rt_link.yaml  |   14 +
 Documentation/netlink/specs/ultraeth.yaml |  218 ++++
 drivers/Kconfig                           |    2 +
 drivers/Makefile                          |    1 +
 drivers/ultraeth/Kconfig                  |   11 +
 drivers/ultraeth/Makefile                 |    4 +
 drivers/ultraeth/uecon.c                  |  324 ++++++
 drivers/ultraeth/uet_chardev.c            |  264 +++++
 drivers/ultraeth/uet_context.c            |  274 +++++
 drivers/ultraeth/uet_job.c                |  456 +++++++++
 drivers/ultraeth/uet_main.c               |   41 +
 drivers/ultraeth/uet_netlink.c            |  113 +++
 drivers/ultraeth/uet_netlink.h            |   29 +
 drivers/ultraeth/uet_pdc.c                | 1122 +++++++++++++++++++++
 drivers/ultraeth/uet_pds.c                |  481 +++++++++
 include/net/ultraeth/uecon.h              |   28 +
 include/net/ultraeth/uet_chardev.h        |   11 +
 include/net/ultraeth/uet_context.h        |   47 +
 include/net/ultraeth/uet_job.h            |   80 ++
 include/net/ultraeth/uet_pdc.h            |  170 ++++
 include/net/ultraeth/uet_pds.h            |  110 ++
 include/uapi/linux/if_link.h              |    8 +
 include/uapi/linux/ultraeth.h             |  536 ++++++++++
 include/uapi/linux/ultraeth_nl.h          |  116 +++
 24 files changed, 4460 insertions(+)
 create mode 100644 Documentation/netlink/specs/ultraeth.yaml
 create mode 100644 drivers/ultraeth/Kconfig
 create mode 100644 drivers/ultraeth/Makefile
 create mode 100644 drivers/ultraeth/uecon.c
 create mode 100644 drivers/ultraeth/uet_chardev.c
 create mode 100644 drivers/ultraeth/uet_context.c
 create mode 100644 drivers/ultraeth/uet_job.c
 create mode 100644 drivers/ultraeth/uet_main.c
 create mode 100644 drivers/ultraeth/uet_netlink.c
 create mode 100644 drivers/ultraeth/uet_netlink.h
 create mode 100644 drivers/ultraeth/uet_pdc.c
 create mode 100644 drivers/ultraeth/uet_pds.c
 create mode 100644 include/net/ultraeth/uecon.h
 create mode 100644 include/net/ultraeth/uet_chardev.h
 create mode 100644 include/net/ultraeth/uet_context.h
 create mode 100644 include/net/ultraeth/uet_job.h
 create mode 100644 include/net/ultraeth/uet_pdc.h
 create mode 100644 include/net/ultraeth/uet_pds.h
 create mode 100644 include/uapi/linux/ultraeth.h
 create mode 100644 include/uapi/linux/ultraeth_nl.h

-- 
2.48.1


