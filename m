Return-Path: <linux-rdma+bounces-8241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECDA4B531
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 23:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DEE16C961
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27651EE7BE;
	Sun,  2 Mar 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="tDc5EHvS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4332AE96;
	Sun,  2 Mar 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740953123; cv=none; b=EVpA+i2trFsVW9PACJYqZ05OKXFqYWRfKSpRBrFVKMQDIFLX+0oq+Avhvc4beiosVzQUrbeXezXmzGwrmrkkpt66TRkQoTi+kVKC5LS3ZokKQ1mvdUtY/ylzYUualnIn5JOAwaL5bvCuR1HMDxYMd6+5622AeukzGHtUDa5hwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740953123; c=relaxed/simple;
	bh=n3s8L5mM1PgkAxQbvIo8KUEt03A6+9fhM7TH5IBuB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tN7MqJGaw+OlPVVDIieWjDOUVL40TIhTo7ucoc5i2srNdHOl8yrTqPdHl4rIMSn/Yc81h5/S2HxQ7H2nskLNxrLEb6W3CeKZurj+t6ERxgDrJfgxzN8mykSx47qN8UqyIhlbpwygQHmJF3zeeJ4TILC9mYH6qTlCz+NN/iKkE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=tDc5EHvS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=eoJEBuDIa3WCsnTjIXl5Vo6lm+iEz4qqSRLteoz5dMQ=; b=tDc5EHvSydJ7KnP1
	tcBaKLkOYCSYzMXaV/FvtgNXZA0S7TsX8c70KsC5ugzY0RtYPTuFr5R0OhRbMVpLGvoRwEVDHHsX0
	bkizDpTQjmklaz7g8HfQ1vErKzreYYEygBX1NkXDgdrAnXdGtX0qcv0aIr4DrFAahho9j+awZix59
	8UfIG3RvQWbR6lzzZtF79iBPN9mQagXWkyOiP6pGvEC1vc5yZTGEQiH+LGZwI6MkLJ9+kfNS5VwdL
	vRfq/cAdmOk+LwOT25or6LBgNBG2K+5m5LRkkoz6tQz7Oky2TbPpI0MJHrzVvIMZ0TsigZIt6hW5q
	2f3fDadw2qt/ym+Z2Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1torQt-001z5E-3C;
	Sun, 02 Mar 2025 22:05:11 +0000
Date: Sun, 2 Mar 2025 22:05:11 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, jgg@ziepe.ca,
	leon@kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Unwired pvrdma_modify_device ?
Message-ID: <Z8TWF6coBUF3l_jk@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:01:01 up 298 days,  9:15,  1 user,  load average: 0.01, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  I noticed that pvrdma_modify_device() in
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?

(I've not got VMWare anywhere to try it on, and don't know the innards
of RDMA drivers; so can't really test it).

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

