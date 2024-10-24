Return-Path: <linux-rdma+bounces-5491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962679AD915
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 03:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC3CB21C71
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 01:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755EF9FE;
	Thu, 24 Oct 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koOjW7ki"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90E4C66;
	Thu, 24 Oct 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731727; cv=none; b=eQOSBD3Ulftth1aZz6GGpLwJm+0KE4sg5+cXofLBsVa+rZPW9X5gGF1OSZDP/UnCHbeeKwncsdXb1vEO+UfwdYFNhwaqQUHmFM5MDLwFm5FsldPDb4TbcvDm5kJCPNyHN9NwsiRD4JFA2uP9g/jsW7nGKICfaT/REmsFRzvrP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731727; c=relaxed/simple;
	bh=N9E3dQrK2oNBJbnVuj4SmkpyBa1i3K9UH1L9aIExYrU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pzTlZ2VSF1CWOL1n4lovV+OpRlb97dC9qoUha87C1UFH5odtfTUMJRX5+LOZLeZb6KfeS95jPDmEJd1Hmn9pacDGXizDTIe7rvGh0pXm9YehKRpzJW5f41Qlc8J/+vIsfin2OOOMITcryZuMqNnP3D2/cMeZPaLtPq25a/nSDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koOjW7ki; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e93d551a3so294114b3a.1;
        Wed, 23 Oct 2024 18:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729731725; x=1730336525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moRdslhIcfQFZ6VJ3Ktj0BaLtFKEuFkVkJRmlDTgxhE=;
        b=koOjW7ki1WQl6F2S8uR/ik8o/G7vD+mLcn7WtQJS/FFq9gEhOsfWeYHYQcC7oYFqLv
         vX1mN0a9wDJdX5bdmGGEWUif2/sDjap1qrF7YWl+ceCWI5TudS2Dgu4AjA0rcmxEocFm
         hT0WPwXl/eq4xwEcqoq0HzYTRHzRw124xOO/hO5sbjakF108v6LrGYIsHeL3ckshAar9
         gZcVLrc7uXhiu+ob7NYAoKyV3qRS8ZbCSyZkdTzDyunxIYCwxC9R/6jPwnq/yxhu2VNl
         bst5u+uXAo88oyOlqVSJOqnXH65wixtXiWd17OiI7SEMzRS4K0mlajdtWYASfhzh24a6
         +LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729731725; x=1730336525;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moRdslhIcfQFZ6VJ3Ktj0BaLtFKEuFkVkJRmlDTgxhE=;
        b=dGeUPpKkzwmUOU5fLitBjJHqUK97QDUfeCSss4kowsZBCenaA7Jivx/DdNxZB1VWdk
         R+jN1ZWU8j0LsiSiJDPa/TwhxBBL+Pg8vlIGdVkc9l7EwN2mFgvSRwHxXQuKKUi80xEU
         9L2pQqo8lhFu+vZkOd+ogobwmbVKDRCeLyc1Bf6eExAatmkFLegM0bIAXiJMnp7jhsWY
         bfK/osyKrjp/lRaPxu5H9t02cnoyRLt65qwUQImz0DhoEoLbgChYzqg6juXMznnQVa0k
         Y5C6syQhHedTpO8m62MQMfPYnKsrdVy/KCu9DxJLuqOcx+CiGPqaMy+uZtldgFs/tE1h
         yMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjdGmkR5LQN7WM4cpRSwJlKm7wwGazPh2nIGDHieE5sYi0z3qK64Zogo/Tg7Be3rvbaDwjDR8+FWpe0mo=@vger.kernel.org, AJvYcCX37QgDbjiFwvgwA3LbkZsSZnz/QQ6xXTi2lr/Dot+s+v/i5z0CZlfTP2mzLgWGS41Ma6D5SHG55prWSsab@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxU2askyzN1qRErRLohSONJ7iG7S5PW7eevwPcZ8Ml6OWTpxK
	17vei+tZgk2Ftrop5Yy0B4o0apUoDKes0J8XW+05sFAqy/8kBDxm
X-Google-Smtp-Source: AGHT+IGJqfilXWarx/ZGLExIGO0dz7Zhrtmh314lBbFCPtvirF6mBhnuLMrv5oztkVLBKOLtYTDQzQ==
X-Received: by 2002:a62:e416:0:b0:720:36c5:b548 with SMTP id d2e1a72fcca58-72036c5b8c4mr3837076b3a.16.1729731724798;
        Wed, 23 Oct 2024 18:02:04 -0700 (PDT)
Received: from [10.4.153.125] ([129.94.128.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d53sm6932499b3a.2.2024.10.23.18.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 18:02:04 -0700 (PDT)
Message-ID: <57cb0385-209e-4cb0-b34c-281e5f99a3d9@gmail.com>
Date: Thu, 24 Oct 2024 09:02:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tuo Li <islituo@gmail.com>
Subject: [BUG] IB/isert: Possible null-pointer dereference related
To: sagi@grimberg.me, jgg@ziepe.ca, leon@kernel.org
Content-Language: en-US
Cc: linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Our static analysis tool has identified a potential null-pointer
dereference related to the wait-completion synchronization mechanism in
ibsert.c.

Consider the following execution scenario:

  isert_login_recv_done()  //1375
    if (isert_conn->conn)  //1390
    complete(&isert_conn->login_req_comp);  //1398

The variable isert_conn->conn is checked by an if statement at Line 1390,
which indicates that isert_conn->conn can be NULL. Then, complete() is
called at Line 1398 which will wake up the wait_for_completion_xxx().

Consider the following wait_for_completion_interruptible().

  isert_get_login_rx()  //2336
    wait_for_completion_interruptible(&isert_conn->login_req_comp); //2342
    isert_rx_login_req(isert_conn);  //2359
      conn = isert_conn->conn;       //981
      login = conn->conn_login;      //982

The value of isert_conn->conn is assigned to conn at Line 981, and then
dereferenced through conn->conn_login at Line 982. However, the variable
isert_conn->conn is checked at Line 1390, which means it can be NULL. If
so, a null-pointer dereference can occur at Line 982.

I am not quite sure whether this possible null-pointer dereference is real
and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Best wishes,
Tuo Li

