Return-Path: <linux-rdma+bounces-10387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2FABABCA
	for <lists+linux-rdma@lfdr.de>; Sat, 17 May 2025 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3CB178168
	for <lists+linux-rdma@lfdr.de>; Sat, 17 May 2025 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E17212FAB;
	Sat, 17 May 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYvwMKUf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BA204F93
	for <linux-rdma@vger.kernel.org>; Sat, 17 May 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747505575; cv=none; b=l1FiOj8RS+FnQMoS/BkWDHEp+icT6YrcjqDxBnstlgWTXmz+6feXQO4JPlShCQ2xCnhWMRWDpbHcO78C1C8lkrWVXm3wA8KRQLaJHs/59byr0jsdFUBGrTjMG8ejruHIqr+5Sg+8atxjMtECrqGvPBmWIpGvdLiNQmfvQoSHnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747505575; c=relaxed/simple;
	bh=BeMgKY3Uh91S5ZbFHQoDIVbOb+B40eZqgaNEmq2kq6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m499vbcy1hhfaZemAvvLsvKRVlS8akDs7Tbgz9DAjCsnP9ocBh6HYvEsxmawLYyOLNkg208ljhZRDp+RTXf0oV1SyO0VARkaRZVJIysQGINdelz5sIbS7ZECeKtLxqLtVhQdQDlrhoBhQHrmboSb/AgP4UW8xmxx3jewVJmD72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYvwMKUf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so24110705e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 17 May 2025 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747505572; x=1748110372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeMgKY3Uh91S5ZbFHQoDIVbOb+B40eZqgaNEmq2kq6s=;
        b=TYvwMKUf5TytkVcbd1Ar7IXKHM/ZePjt+NbMEJUhqtPRj7rAoHx9kZWg7Tj4jA89l/
         6Sgi2nOg6GqYZKqcGcDy64z/dc7vEXvSe1iiYVDRwoE6BpEL20nNCm/5zOF8axdhCkoa
         3VkC8TIwqaX/BOOH8WuUg26l8JQGamxgKu/wL+sfYx7yv589mmmZmRrdL09gkP8mfRHv
         yONq6XrEO50CRXtV57SOywQ98kbCizq00N9UrmYLViMDl+l/bsB6xvRMHyAmvAfQTZNp
         ZH7U4YNrAXjlXF0WeeJCbTTDDM8B3/K3miVuOFnPFKdahXNTVVXQv6m4k+ZT6qMepoVk
         4wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747505572; x=1748110372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeMgKY3Uh91S5ZbFHQoDIVbOb+B40eZqgaNEmq2kq6s=;
        b=O6sPtl/gy/E1Tazk8MI2q+J5HrGajZIimAKMLD3DUnGs7f5jhzn0tFvRnYmrKP5s3c
         o724PDaP2vefNGkwqqnM5hYkHEl1amJhSHrKh+50LI859MCr1SClkmtvc0IkInpalM7r
         N2Mv9UnvCsk1nS2l/IPDsw5tufbv09sVJZEkUvJYro5IOSMS5zn8X/AqSBeuXlt1CunE
         +y9RFOdrLBj97Bf4iq9rh2gNEj5OpTzd9u+r3xjUUFInOCkiAKX+1IQH+7EpBFN910Um
         MkGkHJ/AKPGq5/Epj3PpyPx4+AmXWHziK1x1B7rynQoTeousMB4ctbexXRuezp5NvDrx
         uiCA==
X-Forwarded-Encrypted: i=1; AJvYcCXzUop44ewEjp0zyfYqgTBenmeqnOUOAS9cZupHAgubHM8FS3jDKK6BDynpnHhmW65qeiChkPlGRKi/@vger.kernel.org
X-Gm-Message-State: AOJu0YyORPwCZdAl9QiwJ/lm/VbQsiyQZxEsyzhK1XUiL5WEuFNlRxch
	tN1WjwdU4ft28qNkabGU/gN3DdvRZBR0JjvrIsNoMhHgnVzVF7i8BlfY
X-Gm-Gg: ASbGncu26cmz9z8MgdsUurCU8YIe3VbhaQ01qHUYmnlJeTBKgnccJ0CTlUZW425YziI
	VWYgKNTul9FWerXAx54GZLxIIfI5JMroSmoFIOR6Rj+onXfmOiK5GWg8JQfIFWv6XYg3FTtbbkE
	/0/CtGrlouxJZBT3aQsCKh4VooyD9qeixOazxgD/3n11jM23x3foUw3cCOEpOEcyOV2TGecCDy0
	h3w7f/eXPrpWe0Yh40CGiqGv5yjf/8XM4sx8GlzabgwHuKIWYn9PZ+ZPNxB7oSIJKHCMNNQmVVU
	fIW0v8FH6K9mluA3U6pAmZWRpHJE6Md5IhRJ0GAoOAJUPRI/jTERc5MWuU6NR+c=
X-Google-Smtp-Source: AGHT+IEALcykz/akwNAocIzQbPzEXf74h4NfoYnvQjZSq7JlrWTYSY5BC4ZxICxoPdPa1JPYTQoQ9A==
X-Received: by 2002:a05:600c:3f19:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-442fd63c755mr87596125e9.15.1747505572005;
        Sat, 17 May 2025 11:12:52 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8ce9asm6875895f8f.86.2025.05.17.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 11:12:50 -0700 (PDT)
From: goralbaris <goralbaris@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-rdma@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v2] Replace strncpy with strscpy
Date: Sat, 17 May 2025 21:12:48 +0300
Message-Id: <20250517181248.28913-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408212122.10517-1-goralbaris@gmail.com>
References: <20250408212122.10517-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Any news about this Patch?

Best Regards,
Baris

