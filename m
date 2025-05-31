Return-Path: <linux-rdma+bounces-10925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB3FAC9BB2
	for <lists+linux-rdma@lfdr.de>; Sat, 31 May 2025 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41466189951F
	for <lists+linux-rdma@lfdr.de>; Sat, 31 May 2025 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67488149E13;
	Sat, 31 May 2025 16:20:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C691117A2EA
	for <linux-rdma@vger.kernel.org>; Sat, 31 May 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748708404; cv=none; b=HfH4pGQG2kA4mD7tmTkNE7eQXCVcmmjU/0HXOxhS8L3mHI79de4kSmfQ+52uZEMsxq9D00uZUlRLG3blMnH4isILIPczTGzWGAp32Vrj5r0gXE8lL8HSZ0g1REHKhEa+jtlaQ/5mTTdLxf8IH/g/jiBxqFCBXnoNW7WYLqbXeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748708404; c=relaxed/simple;
	bh=sgPA9Q230YlwYNsgLsUAGT+EIJ3MJXCV8CkuV+njEC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h++K/4vpIsvYxikqgHRuSKSL0BaOQGLUGXCSsWkLQB3Eiq/92MlvaQXyNMwlvfLdB5/qZiUtnC1q916U6noZAfNnIkjUDcKI2mjjyLRZcVcwOY+JsN7HXhc8/HCfnTKA3WbX/Q8O+ncaNMufKhF6h2MV+yZaWBqhIorK4Thk9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3dc854af016so37200725ab.3
        for <linux-rdma@vger.kernel.org>; Sat, 31 May 2025 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748708402; x=1749313202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOT3+3dtKmIMbjiKp4WKPYIYOuy19lzYdhT8ETpxuvo=;
        b=iBR4m2bFL+7oDvCOreJlR7+Red0dvHtyRidJiC+N71c+xZpQtObtfoFXkJqk+UD5T/
         oaIBKB8PRiKNjjsWZIcYXYK2+9Nc8+XFgUJHRdb96mYcUv31lq1WbGAax1OGIvy6KOeU
         XEK4MJ/buDX2ZII+9LkUFWnCak4/aJ46jUyp6G1YO0IqRb7mKtNYKvQlHBdas584TKhU
         60fqEr8S1IWN5PfDwk5NRiQPyVnkz54rZk1YeQRmSxVE5tDg5BSLdd9+nziQpGOIqOIi
         P7iMrummOFkbzjaXJWuaHzzWKZ2WhREMOInu67BP+RoCSuGxhKGY83EaGA7P8FuVNuh2
         xfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+uQAwWPidvU20bSS3FGNWMnwOrENUr4zY1HHHsNMaJXxNMbRDoZM8BR+tX/yPv2xFGZa3/IG644kl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5vZkPqvpigpGmwJ5qchDlUmFWZ+j2lP2XiKpHz9LWhcWbT0d
	C55qlfTJlFly01RbvX+Nc3NNiLtXErna1hU4dByb7+fFzQA25N0gQb7moVvizQpGwHyNEbBxgW9
	9B9bVLnHyxXFlMDlnVsmcxl9blnVdf/XjVWQN/tUPg+s9ivXL2zi/qfclxPw=
X-Google-Smtp-Source: AGHT+IGdap3ueor/+dC4QVfuI3dEjhxnuRezgHUx4IFWYUjshQSu+2Ssy2m7Z8B44GaIOMUzHwVmDX58Z5+KnBdSnlu+zMS+qDxq
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3dd:8a06:4db3 with SMTP id
 e9e14a558f8ab-3dda339232emr19169295ab.19.1748708401944; Sat, 31 May 2025
 09:20:01 -0700 (PDT)
Date: Sat, 31 May 2025 09:20:01 -0700
In-Reply-To: <000000000000ec1f6b061ba43f7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683b2c31.a00a0220.d8eae.001b.GAE@google.com>
Subject: Re: [syzbot] [smc?] possible deadlock in smc_switch_to_fallback (2)
From: syzbot <syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Apr 7 17:03:17 2025 +0000

    smc: Fix lockdep false-positive for IPPROTO_SMC.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13833ed4580000
start commit:   47e55e4b410f openvswitch: fix lockup on tx to unregisterin..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14832cb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e17218580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

