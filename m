Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647C0311E12
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Feb 2021 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBFO4M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBFO4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 09:56:10 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694BC061356
        for <linux-rdma@vger.kernel.org>; Sat,  6 Feb 2021 06:55:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so17708806ejc.1
        for <linux-rdma@vger.kernel.org>; Sat, 06 Feb 2021 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=Oj1NooDuJhVNzbfRQae7N/DRxSBhziAtrV2t7sPiuysNSEB1Bq/QL2bQspKuCoVqlf
         ymBC0IBPQ/EA+JiCrDJsEySghsVWAHVNde56cu02ukG7X2bgzdKxHDuzRQlRcRjA83J7
         f0ATbGfenBmIau3ag1Ovy0EQ+CNpgVgPlaZHAtGM4/xivVXlY6v6Sd93TdmlNJCU0zet
         pe1vyNn2OlTNLLya3uEcJmXhJS/JEYBZsMAKlY3nvbVDqFpz7C0Y4CajEQStwcNnpadH
         tSpI4t+9bDdYitGM8GIP2blS04ueQSvFbETai1f/4oHLASje/RbKPZvGuUSGJdBKpaKl
         lB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=YeO4055ZAQnxchsdMy7AzYBaBs6u+o2ZPAa/YHLGGyUhUt5dvz3q4CLqMT9pN5DbG1
         bl+iuMvEghbc2gXwYU1wuc409WkPDML4tO9OAo6efOSnNrlx9gDkKHosN5+tRWFp8xps
         pZHBNezVQQzvXFDKSyx49uwy+oBpF8LWP6Ql47oSjLUWC5gCqLgfFKfSI5YXb8owO6Di
         aq0jVtOQFkabezduiklfrxieJ2GkBpmvFX3zniuREbz6j9ZQsdXXAw3S1ixo3/6+VpkQ
         l31bITnGlfS6VfgeNtFTADIzwbr89ueICjrMquR8C3x2fvM81v+84UsIDVLcCAZkX+SO
         7e+w==
X-Gm-Message-State: AOAM5333F2KSiOa+tExmcaV29DdZl24Ob6Y1PwkjJrTNF0C90SbAGjQn
        okZhbSgufyL+Z1jvTKPL9PXcX5oHC1bAbJq8DY0=
X-Google-Smtp-Source: ABdhPJwsh5dlnVKHm6RqdTZsPMsuU6pr+O7TnPgOdX4i7yJtViP8kB8eciFWsFnQtN2M4NiANbH0ciIAGqNlzVmLOOY=
X-Received: by 2002:a17:906:442:: with SMTP id e2mr9322413eja.9.1612623339158;
 Sat, 06 Feb 2021 06:55:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:55:38
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:55:38 +0100
Message-ID: <CAGSHw-A_Ecvpef1mn8vrd6X5NeqSEH1E0rtrFWHdDq+p=G2x9w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
