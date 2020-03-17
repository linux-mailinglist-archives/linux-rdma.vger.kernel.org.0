Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9801887F0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 15:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgCQOpN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 10:45:13 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42470 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgCQOpM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 10:45:12 -0400
Received: by mail-pf1-f181.google.com with SMTP id x2so11704733pfn.9
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=+B6CwXbPwKoW/xJraPPI40aM+0Q6AilFXqPUfAECWL4=;
        b=vF7fDdD8G1+Lp59cBARJvmvbs0Nz8AzBinbV4PdsXovJF3kJa0sxUIlYjJ+C/FYW89
         D2NlTU45Re4RGGsEJt1Y/3AAeYCdUn1YR9bUeyLOEMkiloqlJkP0SJFaS87HkdE5ePVZ
         UfB5dOl88BTpKf/AFGxcl7tf09+TFuM41At1MbyYTSe8QvwYSzyNC+nZjjEsobTC1ghe
         PAtMMtpQ37wqnsIL2FiOFv2Cxkosd5cdNz/qRsbpaaO6OHTw19zbLDAGTGIxMFc7d+pA
         Nf49NoiNEoK3qGnKLarKscqELl64zXpvZhX54zobeJMSxezVI03V52LzUwXEq6FaXsKU
         MvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=+B6CwXbPwKoW/xJraPPI40aM+0Q6AilFXqPUfAECWL4=;
        b=kd+1efHNHQ2oYTpOqG21hMeB/kkXZ6T2Ar4anra//FLJ8d2OF9B847LENfMMMjMqi1
         /Ly+8YW7JvNuOZCQUJ9SKfltupijUnHDMEBPf0nPGkbZQOCTBWn1+jAKp12BNOEZ+l9c
         vC/lYeZJ2+9GDSj2+JaiiLi2eUF4INx5ST8iR/oxHle91g+gNghSwd1A/i1afOlN6Xck
         ozsyGJlA4XRO2koxQJ7XA+jYwNU1LpUPO8sKArwswQKPnwvfgbpsuArS0aCPiCsGeQLc
         1Sjsesex0vwVAR2nCifZyecO+6A8oSrJeZnwOD6dbxLjrf5wNrWqykuO4MEqLU0i3Owe
         Smng==
X-Gm-Message-State: ANhLgQ0rTUyPIuTRejaIj39f9EJ+AM3hJfyd73k3uwD+y4Dvr0J9X7SM
        P1gySh4w/idio8Ld3t0q9uY5KIFu1cI=
X-Google-Smtp-Source: ADFU+vusXXldSMaOfgHoy6RN7N8nczLhgRc9XwegPJnU1eg7uZyd3+h8Z13c7wDNrcVi9zIWrU+fdQ==
X-Received: by 2002:a62:e917:: with SMTP id j23mr5833109pfh.154.1584456311547;
        Tue, 17 Mar 2020 07:45:11 -0700 (PDT)
Received: from [192.168.4.4] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id d1sm3405229pfc.3.2020.03.17.07.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 07:45:11 -0700 (PDT)
From:   Andrew Boyer <aboyer@pensando.io>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Lockless behavior for CQs in userspace
Message-Id: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
Date:   Tue, 17 Mar 2020 10:45:08 -0400
Cc:     linux-rdma@vger.kernel.org
To:     Leon Romanovsky <leonro@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Leon,
I understand that we are not to create new providers that use =
environment variables to control locking behavior. The =E2=80=98new=E2=80=99=
 way to do it is to use thread domains and parent domains.

However, even mlx5 still uses the env var exclusively to control =
lockless behavior for CQs. Do you have anything in mind for how to =
extend thread_domains or some other part of the API to cover the CQ =
case?

Thank you,
Andrew

